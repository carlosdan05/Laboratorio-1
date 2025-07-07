.text
.globl main

# Calcula la Secuencia de Fibonacci
# i =  0  1  2  3  4  5  6  7  8  9  10 ...
# x =  0  1  1  2  3  5  8 13 21 34  55 ...

main:
 la $a0, prompt
 li $v0, 4
 syscall    #Mostrar mensaje para ingresar entero

 li $v0, 5
 syscall    #Leer respuesta del usuario

 move $a0, $v0  #Mover i al registro $a0

 jal vfib

 add  $a0, $v0, $zero  #Mostrar resultado
 li $v0, 1
 syscall

 li $v0, 10   #Salir del programa
 syscall

vfib: 
 #Probar valores base
 addi $t0, $zero, 1  #Asignar 1 a $t0
 beq $a0, $zero, fib0 #Ir a retornar 0 si i = 0
 beq $a0, $t0, fib1  #Ir a retornar 1 si i = 1
 j fib

fib0:
 li $v0, 0   #Retornar 0
 jr $ra

fib1:
 li $v0, 1   #Retornar 1
 jr $ra

fib:
 #Reservar espacio en la pila
 addi $sp, $sp, -16  #Reservar espacio para 4 elementos en la pila
     #Guardar $ra e i ahora, sumas después
 sw $ra, 0($sp)  #Guardar dirección de retorno
 sw $a0, 4($sp)  #Guardar i

 #Calcular (fib(n-1))
 addi $a0, $a0, -1  #Decrementar i
 jal vfib   #Llamada recursiva para (fib(n-1))
 sw $v0, 8($sp)  #Guardar valor de (fib(n-1))

 #Calcular (fib(n-2))
 lw $a0, 4($sp)  #Restaurar valor de i desde la pila
 addi $a0, $a0, -2  #Decrementar i dos veces
 jal vfib   #Llamada recursiva para (fib(n-2))
 sw $v0, 12($sp)  #Guardar resultado de (fib(n-2))

 #Restaurar desde la pila y sumar
 lw $ra, 0($sp)  #Cargar dirección de retorno
 lw $t0, 8($sp)  #Cargar (fib(n-1))
 lw $t1, 12($sp)  #Cargar (fib(n-2))
 addi $sp, $sp, 16  #Liberar espacio en la pila
 add $v0, $t0, $t1  #Sumar (fib(n-1) + fib(n-2))

 jr $ra

.data
prompt:  .ascii "Ingresa un número entero no negativo: \n"

