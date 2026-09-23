.data
.text
#SETUP EJERCICIO CONTEO CARACTERES
#Definicion de Direcciones de Memoria
li a0, 0x00FF0000
li a1, 0x00FF0000
addi a1, a1, 0x0000000C
# Creacion y almacenamiento de la primera palabra
li t0, 0x41000000
li t1, 0x004D0000
add t0, t0, t1
li t1, 0x00006100
add t0, t0, t1
li t1, 0x0000004F
add t0, t0, t1
sw t0, 0(a0)
# Creacion y almacenamiento de la segunda palabra
li t0, 0x72000000
li t1, 0x007A0000
add t0, t0, t1
li t1, 0x00006100
add t0, t0, t1
li t1, 0x0000006D
add t0, t0, t1
sw t0, 4(a0)
# Creacion y almacenamiento de la tercera palabra
li t0, 0x75000000
li t1, 0x00420000
add t0, t0, t1
li t1, 0x00006100
add t0, t0, t1
li t1, 0x0000004D
add t0, t0, t1
sw t0, 8(a0)
# Creacion y almacenamiento de la cuarta palabra
li t0, 0x78000000
li t1, 0x004B0000
add t0, t0, t1
li t1, 0x00006100
add t0, t0, t1
li t1, 0x00000065
add t0, t0, t1
sw t0, 12(a0)
# Reinicio de registros segun necesidades del ejercicio
li t0, 0
li t1, 0
li s1, 0
li s2, 0
li s3, 0
li s4, 0
li s5, 0
li s6, 0
li s7, 0
li s8, 0
# ESPACIO PARA SOLUCION
lw t2, 0(a0)
andi t3, t2, 0xFF # el registro t4 guarda los bits 0-9 de 0(t0)
srli t2, t2, 8 # desplazo a la derecha el registro t3, 10 posiciones y lo guardo en t3
andi t4, t2, 0xFF # el registro t5 guarda los bits 10-13 de 0(t0)
srli t2, t2, 8 # desplazo a la derecha el registro t3, 4 posiciones y lo guardo en t3
andi t5, t2, 0xFF # el registro t6 guarda los bits 14-18 de 0(t0)
srli t2, t2, 8 # desplazo a la derecha el registro t3, 5 posiciones y lo guardo en t3
andi t6, t2, 0xFF # el registro s1 guarda los bits 19-29 de 0(t0)
srli t2, t2, 8 # desplazo a la derecha el registro t3, 11 posiciones y lo guardo en t3

# realizar un or en el bit 6 para convertir una palabra de minúscula a mayúscula
ori t3, t3, 32
ori t4, t4, 32
ori t5, t5, 32
ori t6, t6, 32

#multiplico por 4 el valor de la dirección para que sea multiplo de 4
slli t3, t3, 2
slli t4, t4, 2
slli t5, t5, 2
slli t6, t6, 2

# dirección de a0+el número de la palabra que acaba de encontrar
add s1, a1, t3 # dirección
add s2, a1, t4 # dirección
add s3, a1, t5 # dirección
add s4, a1, t6 # dirección

# devuelvo la palabra a su posicion inicial
srli t3, t3, 2
srli t4, t4, 2
srli t5, t5, 2
srli t6, t6, 2

# agrego +1 en el contenido de la dirección en sx, para aumentar el contador de esa palabra
lw s5, 0(s1)
addi s5, s5, 1
sw s5, 0(s1)
lw s5, 0(s2)
addi s5, s5, 1
sw s5, 0(s2)
lw s5, 0(s3)
addi s5, s5, 1
sw s5, 0(s3)
lw s5, 0(s4)
addi s5, s5, 1
sw s5, 0(s4)

# ahora usando el contenido de esas direcciones, sé cuales son el # de caracteres con repeticion
# uso esos números para saber la posición en otros registros para guardarlos en a1

sw s6, 0(s1) # carga el contador de la palabra de 1 
slli s6, s6, 2 # multiplica por 4 el contador
add s6, s6, a1 # le suma el contador a la dirección de la palabra 
lw t3, 0(s6)

sw s6, 0(s2) # carga el contador de la palabra de 1 
slli s6, s6, 2 # multiplica por 4 el contador
add s6, s6, a1 # le suma el contador a la dirección de la palabra 
lw t4, 0(s6)

sw s6, 0(s3) # carga el contador de la palabra de 1 
slli s6, s6, 2 # multiplica por 4 el contador
add s6, s6, a1 # le suma el contador a la dirección de la palabra 
lw t5, 0(s6)

sw s6, 0(s4) # carga el contador de la palabra de 1 
slli s6, s6, 2 # multiplica por 4 el contador
add s6, s6, a1 # le suma el contador a la dirección de la palabra 
lw t6, 0(s6)

