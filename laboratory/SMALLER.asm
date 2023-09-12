.data
    prompt1: .asciiz "Ingresa el primer número: "
    prompt2: .asciiz "Ingresa el segundo número: "
    prompt3: .asciiz "Ingresa el tercer número: "
    result: .asciiz "El número menor es: "
    all_equal_msg: .asciiz "Todos los números son iguales."

.text
.globl main

main:
    # Pide al usuario ingresar el primer número
    li $v0, 4
    la $a0, prompt1
    syscall

    # Lee el primer número y almacénalo en $t0
    li $v0, 5
    syscall
    move $t0, $v0

    # Pide al usuario ingresar el segundo número
    li $v0, 4
    la $a0, prompt2
    syscall

    # Lee el segundo número y almacénalo en $t1
    li $v0, 5
    syscall
    move $t1, $v0

    # Pide al usuario ingresar el tercer número
    li $v0, 4
    la $a0, prompt3
    syscall

    # Lee el tercer número y almacénalo en $t2
    li $v0, 5
    syscall
    move $t2, $v0

    # Compara si los números son iguales
    beq $t0, $t1, igual1
    beq $t0, $t2, igual2
    beq $t1, $t2, igual3
    j no_iguales

igual1:
    # Los dos primeros números son iguales, comparar con el tercero
    beq $t1, $t2, iguales
    j no_iguales

igual2:
    # El primer y tercer números son iguales, comparar con el segundo
    beq $t0, $t1, iguales
    j no_iguales

igual3:
    # El segundo y tercer números son iguales, comparar con el primero
    beq $t0, $t2, iguales
    j no_iguales

iguales:
    # Todos los números son iguales, mostrar el resultado
    li $v0, 4
    la $a0, all_equal_msg
    syscall
    j exit

no_iguales:
    # Inicializar $t3 con el primer número para comenzar la comparación
    move $t3, $t0

    # Compara $t3 con $t1
    blt $t3, $t1, compare_t3_t2
    move $t3, $t1

compare_t3_t2:
    # Compara $t3 con $t2
    blt $t3, $t2, print_result
    move $t3, $t2

print_result:
    # Muestra el resultado (el número menor)
    li $v0, 4
    la $a0, result
    syscall

    # Muestra el número menor almacenado en $t3
    move $a0, $t3
    li $v0, 1
    syscall

exit:
    # Termina el programa
    li $v0, 10
    syscall
