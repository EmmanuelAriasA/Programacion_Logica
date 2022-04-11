# Abrimos nuestro archivo txt donde guardamos nuestros puntos
with open("Mensaje.txt", "r") as File:
    # Usamos el método extend para copiar todo el contenido de esa lista de numeros a otra lista llamada mensaje
	mensaje = File.read()
# Cerramos el archivo
File.close()

def xor_encryption(mensaje, clave, ascii_mensaje, ascii_clave):
    longitud = len(mensaje)
    cont = 0
    encrypt_mensaje = ""
    
    for i in range(longitud):
        if(cont>=len(clave)):
            cont=0
        encrypt = ascii_mensaje[i] ^ ascii_clave[cont]
        cont = cont+1
        encrypt_mensaje += chr(encrypt)
    return encrypt_mensaje

def decryption(encriptado, clave, ascii_clave):
    longitud = len(encriptado)
    cont = 0
    decryption_mensaje = ""
    
    for i in range(longitud):
        if(cont>= len(clave)):
            cont = 0
        desencriptado = ord(encriptado[i]) ^ ascii_clave[cont]
        cont = cont + 1
        decryption_mensaje += chr(desencriptado)
    return decryption_mensaje

# Se ingresa la clave de encriptacion
clave = input("Clave de encriptacion: ")
# Pasamos a ASCII el mensaje y la clave para poder trabajar la funcion XOR
ascii_mensaje = [ord(char) for char in mensaje]
ascii_clave = [ord(char) for char in clave]

# Encripta el mensaje
encriptado = xor_encryption(mensaje, clave, ascii_mensaje, ascii_clave)
# Desencripta el mensaje
desencriptado = decryption(encriptado, clave, ascii_clave)

# Imprimimos en consola
print(encriptado)
print(desencriptado)

# Guardamos el texto encriptado en nuestro archivo de texto
with open("Encriptado.txt", "w") as Encriptado:
    Encriptado.write(encriptado)
Encriptado.close()
