.data
    prompt: .asciiz "Ingrese el valor de n: "
    result_msg: .asciiz "Los primeros n términos de la Serie de Fibonacci son: "
    space: .asciiz " "  # Cadena con un espacio en blanco
    
.text
.globl main

main:
    # Pide al usuario ingresar el valor de n
    li $v0, 4
    la $a0, prompt
    syscall

    # Lee el valor de n ingresado por el usuario
    li $v0, 5
    syscall
    move $t0, $v0  # $t0 contiene el valor de n

    # Inicializa los primeros dos términos de la Serie de Fibonacci
    li $t1, 0  # Primer término: F(0) = 0
    li $t2, 1  # Segundo término: F(1) = 1

    # Imprime el mensaje inicial
    li $v0, 4
    la $a0, result_msg
    syscall

    # Calcula y muestra los primeros n términos de la Serie de Fibonacci
    loop:
        # Muestra el valor actual de la Serie de Fibonacci
        move $a0, $t1
        li $v0, 1
        syscall

        # Muestra un espacio en blanco
        li $v0, 4
        la $a0, space
        syscall

        # Calcula el siguiente término de la Serie de Fibonacci: F(i+2) = F(i) + F(i+1)
        add $t3, $t1, $t2  # $t3 = F(i) + F(i+1)
        move $t1, $t2      # Actualiza F(i) con el valor de F(i+1)
        move $t2, $t3      # Actualiza F(i+1) con el valor de F(i+2)

        # Decrementa n y verifica si debemos continuar
        subi $t0, $t0, 1
        bnez $t0, loop

    # Termina el programa
    li $v0, 10
    syscall