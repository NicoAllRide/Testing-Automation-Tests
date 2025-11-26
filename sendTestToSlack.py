import logging
import sys
import os
import re
from robot.api import ExecutionResult
from robot.result.visitor import ResultVisitor
from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError
from xml.etree import ElementTree as ET

SLACK_TOKEN = "xoxb-3501329970642-7009206964070-Wk86svxwZwdJaY11UpUJ1qP1"

logging.basicConfig(level=logging.DEBUG)

class TestResultAnalyzer(ResultVisitor):
    def __init__(self, xml_path):
        self.passed_tests = 0
        self.failed_tests = 0
        self.failed_test_info = []
        self.custom_failed_test_info = []
        self.server_errors = []
        self.current_file = "Unknown File"
        self.xml_path = xml_path

    def visit_suite(self, suite):
        if suite.source:
            self.current_file = os.path.basename(suite.source)
        suite.tests.visit(self)
        suite.suites.visit(self)

    def visit_test(self, test):
        logging.debug(f"Visiting test: {test.name}, Status: {test.status}")
        if test.status == 'PASS':
            self.passed_tests += 1
        elif test.status == 'FAIL':
            self.failed_tests += 1
            error_message = self.extract_detailed_error_message(test.message)
            request_info = self.extract_request_info_from_logs(test.name)
            documentation = test.doc or "No documentation provided."
            logging.debug(f"Test Failed: {test.name}, Error Message: {error_message}")

            if self.is_server_error(error_message):
                self.server_errors.append({
                    "file_name": self.current_file,
                    "test_name": test.name,
                    "documentation": documentation,
                    "error_message": error_message,
                    "request_info": request_info,
                })

            if self.has_custom_message(error_message):
                fail_reason = self.extract_custom_message(error_message)
                self.custom_failed_test_info.append({
                    "file_name": self.current_file,
                    "fail_reason": fail_reason,
                    "request_info": request_info,
                    "test_name": test.name,
                    "documentation": documentation,
                    "error_message": error_message,
                })
            else:
                self.failed_test_info.append({
                    "file_name": self.current_file,
                    "test_name": test.name,
                    "documentation": documentation,
                    "error_message": error_message,
                    "request_info": request_info,
                })

    def is_server_error(self, error_message):
        return re.search(r'5\d{2} Server Error', error_message) is not None

    def has_custom_message(self, error_message):
        patterns = [
            "No accesToken found", "Validation failed", "Missing fields",
            r"No services were created with routeId\._id",
            "Doesn't discounts tickets after validation",
            "Total tickets after validation should be",
            "User validated, should not be able to validate",
            "no tickets assigned", "could not reserve, failing",
            "Departures created dont have the selected route",
            "Reservations should be empty but is not",
            "release seats not working",
            "passenger couldn't validate in service with available seats"
        ]
        return any(re.search(pattern, error_message) for pattern in patterns)

    def extract_custom_message(self, error_message):
        if "No accesToken found" in error_message:
            return "No accessToken found in Login!, Failing"
        if "Validation failed" in error_message:
            return "User validation failed due to missing fields"
        if re.search(r"No services were created with routeId\._id", error_message):
            return "No services were created with routeId._id. All related tests failing."
        if "Doesn't discounts tickets after validation" in error_message:
            return "Ticket discount validation failed. Tickets were not discounted after validation."
        if "Total tickets after validation should be" in error_message:
            return "Ticket total after validation does not match expectations."
        if "User validated, should not be able to validate" in error_message:
            return "User improperly validated but should not have access."
        if "no tickets assigned" in error_message:
            return "Tickets were not assigned as expected."
        if "could not reserve, failing" in error_message:
            return "Reservation failed for user with certification webcontrol."
        if "Departures created dont have the selected route" in error_message:
            return "Departures created do not match the selected route."
        if "Reservations should be empty but is not" in error_message:
            return "Reservations list is not empty when it should be. Release seats functionality is not working."
        if "release seats not working" in error_message:
            return "Release seats functionality failed to work properly."
        if "passenger couldn't validate in service with available seats" in error_message:
            return "Passenger validation failed despite service having available seats."
        if "Departure has no validation details, check again for possible failing" in error_message:
            return "Departure has no validation details. This might indicate a failure."
        return "Custom error message not defined"

    def extract_detailed_error_message(self, message):
        body_match = re.search(r'(?<=Response Body: ).*', message, re.DOTALL)
        return body_match.group(0) if body_match else message

    def extract_request_info_from_logs(self, test_name):
        tree = ET.parse(self.xml_path)
        root = tree.getroot()
        for test in root.iter('test'):
            if test.attrib['name'] == test_name:
                for kw in test.iter('kw'):
                    for msg in kw.iter('msg'):
                        if re.search(r'(GET|POST|PUT|DELETE) Request : url=', msg.text):
                            request_info = msg.text.split('path_url=')[0].strip()
                            return request_info
        return "No request info found"

    def generate_fail_report(self):
        report_sections = []
        if self.server_errors:
            report_sections.append("\nServer Errors:\n" + "-" * 50 + "\n" + "".join([
                f"[Test Name: {e['test_name']}]\nFile Name: {e['file_name']}\nDocumentation: {e['documentation']}\nError Message: {e['error_message']}\nRequest Info: {e['request_info']}\n{'-' * 50}\n"
                for e in self.server_errors
            ]))
        if self.custom_failed_test_info:
            report_sections.append("\nFailed Test Cases (Summary):\n" + "-" * 50 + "\n" + "".join([
                f"Failed ({t['file_name']}) Test Cases:\nFail reason: {t['fail_reason']}\nDocumentation: {t['documentation']}\nRequest Info: {t['request_info']}\n{'-' * 50}\n"
                for t in self.custom_failed_test_info
            ]))
        if self.failed_test_info or self.custom_failed_test_info:
            report_sections.append("\nAll Failed Test Cases:\n" + "-" * 50 + "\n" + "".join([
                f"[Test Name: {t['test_name']}]\nFile Name: {t['file_name']}\nDocumentation: {t['documentation']}\nError Message: {t['error_message']}\nRequest Info: {t['request_info']}\n{'-' * 50}\n"
                for t in self.failed_test_info + self.custom_failed_test_info
            ]))
        return "\n".join(report_sections)


if __name__ == '__main__':
    try:
        output_file = sys.argv[1] if len(sys.argv) > 1 else "output.xml"
        result = ExecutionResult(output_file)
        analyzer = TestResultAnalyzer(output_file)
        result.visit(analyzer)

        total_tests = analyzer.passed_tests + analyzer.failed_tests
        passed_percentage = (analyzer.passed_tests / total_tests) * 100 if total_tests > 0 else 0

        message_text = (
            f"Resultado de las pruebas:\n"
            f"Total Tests: {total_tests}\n"
            f"Passed Tests: {analyzer.passed_tests}\n"
            f"Failed Tests: {analyzer.failed_tests}\n"
            f"Server Errors: {len(analyzer.server_errors)}\n"
            f"Passed Percentage: {passed_percentage:.2f}%\n"
        )

        client = WebClient(token=SLACK_TOKEN)
        response = client.chat_postMessage(channel="C070FNX0CHG", text=message_text)
        if response["ok"]:
            print("Mensaje enviado a Slack exitosamente.")
        else:
            print(f"Error al enviar el mensaje a Slack: {response['error']}")

        if analyzer.failed_tests > 0 or len(analyzer.server_errors) > 0:
            with open("detalle_pruebas.txt", "w", encoding="utf-8") as file:
                file.write(analyzer.generate_fail_report())
            with open("detalle_pruebas.txt", "r", encoding="utf-8") as file:
                file_content = file.read()
            new_file = client.files_upload_v2(
                title="detalle_pruebas",
                filename="detalle_pruebas.txt",
                content=file_content,
            )
            file_url = new_file.get("file").get("permalink")
            client.chat_postMessage(channel="C070FNX0CHG", text=f"Detalle de pruebas fallidas: {file_url}")
        else:
            print("Todas las pruebas pasaron. No se enviará archivo de detalles.")

    except SlackApiError as e:
        print(f"Error al enviar el mensaje a Slack: {e.response['error']}")
