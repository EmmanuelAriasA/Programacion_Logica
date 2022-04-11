#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void encriptarDesencriptar(char *, char *, char *);

int main(int argc, char *argv[])
{
    char *clave = NULL;
    FILE *prueba = fopen(argv[1], "r");
    FILE *encriptado = fopen("encriptado.txt", "w");
    FILE *desencriptado = fopen("desencriptado.txt", "w");
    char *buffer = 0;
    long longitud;

    clave = (char *)malloc(strlen(argv[2]) + 1);
    strncpy(clave, argv[2], strlen(argv[2]));

    for (size_t i = 0; i < strlen(clave); ++i)
        clave[i] = toupper(clave[i]);
        
    if (prueba)
    {
        fseek(prueba, 0, SEEK_END);
        longitud = ftell(prueba);  
        fseek(prueba, 0, SEEK_SET);
        buffer = (char *)malloc(longitud);

        if (buffer)
        {
            fread(buffer, 1, longitud, prueba);
        }
        fclose(prueba);
    }

    size_t tamagnoBuffer = strlen(buffer) + 1;

    char mensajeEncriptado[tamagnoBuffer];
    memset(mensajeEncriptado, '\0', sizeof(mensajeEncriptado));
    encriptarDesencriptar(buffer, mensajeEncriptado, clave);
    fprintf(encriptado, "%s", mensajeEncriptado);

    printf("Encriptado...\n");

    char mensajeDesencriptado[tamagnoBuffer];
    memset(mensajeDesencriptado, '\0', sizeof(mensajeDesencriptado));
    encriptarDesencriptar(mensajeEncriptado, mensajeDesencriptado, clave);
    fprintf(desencriptado, "%s", mensajeDesencriptado);

    printf("Desencriptado!\n");

    fclose(encriptado);
    fclose(desencriptado);
    return 0;
}

void encriptarDesencriptar(char *entrada, char *salida, char *clave)
{
    for (int i = 0; i < strlen(entrada); ++i)
        salida[i] = entrada[i] ^ clave[i % strlen(clave)];
}