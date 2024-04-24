import sys
import json
import requests
from robot.api import ExecutionResult
from robot.result.visitor import ResultVisitor

class TestResultAnalyzer(ResultVisitor):
    def __init__(self):
        self.passed_tests = 0
        self.failed_tests = 0
        self.failed_test_info = []

    def visit_test(self, test):
        if test.status == 'PASS':
            self.passed_tests += 1
        elif test.status == 'FAIL':
            self.failed_tests += 1
            error_message = test.message if test.message else "No error message"
            self.failed_test_info.append({'Test Name': test.name, 'Error Message': error_message})

if __name__ == '__main__':
    try:
        output_file = sys.argv[1]
    except IndexError:
        output_file = "output.xml"
        
    result = ExecutionResult(output_file)
    analyzer = TestResultAnalyzer()
    result.visit(analyzer)
    
    total_tests = analyzer.passed_tests + analyzer.failed_tests
    if total_tests > 0:
        passed_percentage = (analyzer.passed_tests / total_tests) * 100
    else:
        passed_percentage = 0
        
    print(f"Total Tests: {total_tests}")
    print(f"Passed Tests: {analyzer.passed_tests}")
    print(f"Failed Tests: {analyzer.failed_tests}")
    print(f"Passed Percentage: {passed_percentage:.2f}%")
    
    print("\nFailed Test Cases:")
    for test_info in analyzer.failed_test_info:
        print("Test Name:")
        print(test_info['Test Name'])
        print("\nError Message:")
        print(test_info['Error Message'])
        print("\n" + "-" * 50)
        
    # Construir el mensaje a enviar a Slack
    message = {
        "text": f"Resultado de las pruebas:\nTotal Tests: {total_tests}\nPassed Tests: {analyzer.passed_tests}\nFailed Tests: {analyzer.failed_tests}\nPassed Percentage: {passed_percentage:.2f}%\n\nFailed Test Cases:\n" + "\n".join([f"Test Name:\n{test_info['Test Name']}\n\nError Message:\n{test_info['Error Message']}\n\n{'-' * 50}\n" for test_info in analyzer.failed_test_info])
    }
    
    # URL del webhook de Slack
    webhook_url = 'https://hooks.slack.com/services/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'
    
    # Enviar el mensaje a Slack
    response = requests.post(webhook_url, data=json.dumps(message), headers={'Content-Type': 'application/json'})
    
    # Verificar si la solicitud fue exitosa
    if response.status_code == 200:
        print("Mensaje enviado a Slack exitosamente.")
    else:
        print("Error al enviar el mensaje a Slack.")
