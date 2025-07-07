.text
.globl main

main:
    # Mostrar mensaje de entrada
    la $a0, prompt
    li $v0, 4
    syscall

    # Leer entero n
    li $v0, 5
    syscall
    move $t0, $v0        # $t0 = n

    # Casos base: si n == 0 o n == 1
    li $t1, 0            # fib0 = 0
    li $t2, 1            # fib1 = 1
    beq $t0, $zero, print_fib0
    li $t3, 1
    beq $t0, $t3, print_fib1

    # Iterar desde i = 2 hasta n
    li $t3, 2            # i = 2
loop:
    add $t4, $t1, $t2    # t4 = fib(i-2) + fib(i-1)
    move $t1, $t2        # fib(i-2) = fib(i-1)
    move $t2, $t4        # fib(i-1) = fib(i)
    addi $t3, $t3, 1     # i++
    ble $t3, $t0, loop   # repetir mientras i <= n

    # Imprimir resultado (fib(n) está en $t2)
    move $a0, $t2
    li $v0, 1
    syscall
    j exit

print_fib0:
    li $a0, 0
    li $v0, 1
    syscall
    j exit

print_fib1:
    li $a0, 1
    li $v0, 1
    syscall

exit:
    li $v0, 10
    syscall

.data
prompt: .asciiz "Ingresa un número entero no negativo: "

