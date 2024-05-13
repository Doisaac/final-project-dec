#include <stdio.h>
#include <stdlib.h>
#include <ctype.h> 

/*
  * Tamaño De Matriz 3x3 (CONSTANTE)
  * n n n
  * n n n
  * n n n
*/
#define TAMANIO_MATRIZ 3

/*
  * Verifica si el input es mayor o igual a 0, pero menor o igual a 9.
  * retorna: true si es válido, false si no lo es.
*/
int verificaInput(char input[]) {
    if (
      isdigit(input[0])
    ) {
        int numeroIngresado = atoi(input); 
        
        if (numeroIngresado >= 0 && numeroIngresado <= 9) {
            return 1; 
        } else {
            printf("Error: Ingrese un número entre 0 y 9.\n");
            return 0; 
        }
    } else {
        printf("Error: Ingrese un número.\n");
        return 0; 
    }
}

int main() {
    int matriz[TAMANIO_MATRIZ][TAMANIO_MATRIZ];
    int fila, columna;

    printf("Ingrese los números para la matriz 3x3:\n");
    for (fila = 0; fila < TAMANIO_MATRIZ; fila++) {
        for (columna = 0; columna < TAMANIO_MATRIZ; columna++) {
            int numeroEntero;
            char input[3]; 
            
            do {
                printf("Ingrese el número para fila %d, columna %d: ", fila + 1, columna + 1);
                scanf("%s", input); 
            } while (!verificaInput(input));
            
            numeroEntero = atoi(input); 
            matriz[fila][columna] = numeroEntero;
        }
    }

    printf("\nMatriz Ingreseda:\n");
    for (fila = 0; fila < TAMANIO_MATRIZ; fila++) {
        for (columna = 0; columna < TAMANIO_MATRIZ; columna++) {
            printf("%d ", matriz[fila][columna]);
        }
        printf("\n");
    }
    
    return 0;
}

