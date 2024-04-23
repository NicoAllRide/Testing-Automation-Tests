import random
from openpyxl import Workbook

# Función para generar un número de RUT falso de 9 dígitos
def generar_rut():
    return ''.join(str(random.randint(0, 9)) for _ in range(9))

# Número de usuarios que quieres generar
num_usuarios = 7000

# Crear un libro de trabajo de Excel
wb = Workbook()
ws = wb.active

# Agregar encabezados
ws.append(["Nombre", "RUT", "Habilitar transporte privado", "Permitir crear rutas en RDD", 
           "Requerir aprobación de rutas creadas en RDD", "Rutas RDD exclusivas", 
           "Permitir crear rutas de RDD de alta prioridad"])

# Generar nombres de usuario y números de RUT falsos y escribir en el archivo Excel
for i in range(1, num_usuarios + 1):
    nombre_usuario = "usuario{}".format(i)
    rut_falso = generar_rut()
    ws.append([nombre_usuario, rut_falso, "", "", "", "", ""])

# Guardar el libro de trabajo en un archivo Excel
nombre_archivo = 'usuarios_sin_pandas.xlsx'
wb.save(nombre_archivo)

print("Se han generado y guardado {} usuarios en el archivo '{}'.".format(num_usuarios, nombre_archivo))
