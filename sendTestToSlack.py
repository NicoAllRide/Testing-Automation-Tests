
import logging
import sys
import os
import json
import requests
from robot.api import ExecutionResult
from robot.result.visitor import ResultVisitor
from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError

SLACK_TOKEN = os.environ["SLACK_TOKEN"]

# Configurar el nivel de depuración del registro
logging.basicConfig(level=logging.DEBUG)

# Definir la clase para analizar los resultados de las pruebas
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
        
    # Construir el mensaje a enviar a Slack
    message = {
       "text": f"Resultado de las pruebas:\nTotal Tests: {total_tests}\nPassed Tests: {analyzer.passed_tests}\nFailed Tests: {analyzer.failed_tests}\nPassed Percentage: {passed_percentage:.2f}%"
    }

    # Inicializar el cliente de la API web de Slack con tu token de autenticación
    client = WebClient(token=SLACK_TOKEN)

    try:
        # Enviar el mensaje a Slack
        response = client.chat_postMessage(
            channel="C070FNX0CHG",  # Reemplaza esto con el ID de tu canal
            text=message["text"]
        )

        # Verificar si la solicitud fue exitosa
        if response["ok"]:
            print("Mensaje enviado a Slack exitosamente.")
        else:
            print(f"Error al enviar el mensaje a Slack: {response['error']}")

    except SlackApiError as e:
        print(f"Error al enviar el mensaje a Slack: {e.response['error']}")

    # Guardar el detalle en un archivo
    with open("detalle_pruebas.txt", "w") as file:
        file.write("Failed Test Cases:\n")
        for test_info in analyzer.failed_test_info:
            file.write(f"Test Name: {test_info['Test Name']}\n")
            file.write(f"Error Message: {test_info['Error Message']}\n")
            file.write("-" * 50 + "\n")
    
    print("Detalle de las pruebas guardado en 'detalle_pruebas.txt'.")


# Configurar el nivel de depuración del registro
logging.basicConfig(level=logging.DEBUG)

# Inicializar el cliente de la API web de Slack con tu token de autenticación
client = WebClient(token=SLACK_TOKEN)

# Probar si el token es válido
auth_test = client.auth_test()
bot_user_id = auth_test["user_id"]
print(f"ID de usuario del bot: {bot_user_id}")

# Leer el contenido del archivo
with open("detalle_pruebas.txt", "r") as file:
    file_content = file.read()

# Subir un archivo con el contenido leído del archivo
new_file = client.files_upload_v2(
    title="detalle_pruebas",
    filename="detalle_pruebas.txt",
    content=file_content,  # Pasar el contenido del archivo aquí
)

# Compartir el archivo en un canal
file_url = new_file.get("file").get("permalink")
new_message = client.chat_postMessage(
    channel="C070FNX0CHG",  # Reemplaza esto con el ID de tu canal
    text=f"Detalle de pruebas fallidas: {file_url}",
)
