section .data
    prompt db 'Ingrese un numero (0-9): ', 0
    prompt_len equ $ - prompt
    invalid_input_msg db 'Entrada invalida. Por favor ingrese un valor adecuado: ', 0
    invalid_input_msg_len equ $ - invalid_input_msg
    matrix db 9 dup(0)  ; Espacio para la matriz 3x3
    transposed db 9 dup(0)  ; Espacio para la matriz traspuesta
    newline db 10, 0

section .bss
    input resb 2  ; Espacio para almacenar la entrada del usuario

section .text
    global _start

_start:
    ; Capturar los elementos de la matriz
    mov ecx, 9
    mov esi, matrix
captura_loop:
    push ecx
    push esi
    call captura_numero
    pop esi
    pop ecx
    mov [esi], al
    inc esi
    loop captura_loop

    ; Calcular la traspuesta de la matriz
    call transponer_matriz

    ; Mostrar la matriz original
    mov ecx, 9
    mov esi, matrix
    call display_matrix
    call print_newline

    ; Mostrar la matriz traspuesta
    mov ecx, 9
    mov esi, transposed
    call display_matrix
    call print_newline

    ; Salir del programa
    call exit

captura_numero:
    ; Mostrar el prompt
    mov eax, 4
    mov ebx, 1
    mov edx, prompt_len
    mov ecx, prompt
    int 0x80

    ; Leer la entrada del usuario
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 2
    int 0x80

    ; Validar que sea un número del 0 al 9
    mov al, [input]
    cmp al, '0'
    jb invalid_input  ; Si es menor que '0', es inválido
    cmp al, '9'
    ja invalid_input  ; Si es mayor que '9', es inválido
    sub al, '0'  ; Convertir carácter a número
    ret

invalid_input:
    ; Mostrar mensaje de entrada inválida
    mov eax, 4
    mov ebx, 1
    mov edx, invalid_input_msg_len
    mov ecx, invalid_input_msg
    int 0x80
    jmp captura_numero

transponer_matriz:
    ; Transponer la matriz 3x3
    mov esi, matrix
    mov edi, transposed

    mov al, [esi]
    mov [edi], al
    mov al, [esi+1]
    mov [edi+3], al
    mov al, [esi+2]
    mov [edi+6], al

    mov al, [esi+3]
    mov [edi+1], al
    mov al, [esi+4]
    mov [edi+4], al
    mov al, [esi+5]
    mov [edi+7], al

    mov al, [esi+6]
    mov [edi+2], al
    mov al, [esi+7]
    mov [edi+5], al
    mov al, [esi+8]
    mov [edi+8], al

    ret

display_matrix:
    ; Mostrar una matriz en formato 3x3
    mov ecx, 3
display_matrix_row:
    push ecx
    mov ecx, 3
display_matrix_col:
    push ecx
    push esi
    call display_numero
    pop esi
    pop ecx
    inc esi
    loop display_matrix_col
    call print_newline
    pop ecx
    loop display_matrix_row
    ret

display_numero:
    ; Convertir el número a carácter y mostrarlo
    mov al, [esi]
    add al, '0'
    mov [input], al
    mov eax, 4
    mov ebx, 1
    mov ecx, input
    mov edx, 1
    int 0x80
    ret

print_newline:
    ; Mostrar nueva línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80

