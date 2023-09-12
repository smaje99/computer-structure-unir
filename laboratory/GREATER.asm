.data
    prompt1: .asciiz "Ingresa el primer número: "
    prompt2: .asciiz "Ingresa el segundo número: "
    prompt3: .asciiz "Ingresa el tercer número: "
    result: .asciiz "Los números son iguales."
    result2: .asciiz "El número mayor es: "

.text
.globl main

main:
    # Pide al usuario ingresar el primer número
    li $v0, 4
    la $a0, prompt1
    syscall

    # Lee el primer número y lo almacena en $t0
    li $v0, 5
    syscall
    move $t0, $v0

    # Pide al usuario ingresar el segundo número
    li $v0, 4
    la $a0, prompt2
    syscall

    # Lee el segundo número y lo almacena en $t1
    li $v0, 5
    syscall
    move $t1, $v0

    # Pide al usuario ingresar el tercer número
    li $v0, 4
    la $a0, prompt3
    syscall

    # Lee el tercer número y lo almacena en $t2
    li $v0, 5
    syscall
    move $t2, $v0

    # Compara si los números son iguales
    beq $t0, $t1, equal1
    beq $t0, $t2, equal2
    beq $t1, $t2, equal3
    j no_equals

equal1:
    # Los dos primeros números son iguales, compara con el tercero
    beq $t1, $t2, equals
    j no_equals

equal2:
    # El primer y tercer números son iguales, compara con el segundo
    beq $t0, $t1, equals
    j no_equals

equal3:
    # El segundo y tercer números son iguales, compara con el primero
    beq $t0, $t2, equals
    j no_equals

equals:
    # Los tres números son iguales, muestra el resultado
    li $v0, 4
    la $a0, result
    syscall
    j exit

no_equals:
    # Inicializa $t3 con el primer número para comenzar la comparación
    move $t3, $t0

    # Compara $t3 con $t1
    bgt $t3, $t1, compare_t3_t2
    move $t3, $t1

compare_t3_t2:
    # Compara $t3 con $t2
    bgt $t3, $t2, print_result
    move $t3, $t2

print_result:
    # Muestra el resultado (el número mayor)
    li $v0, 4
    la $a0, result2
    syscall

    # Muestra el número mayor almacenado en $t3
    move $a0, $t3
    li $v0, 1
    syscall

exit:
    # Termina el programa
    li $v0, 10
    syscall
