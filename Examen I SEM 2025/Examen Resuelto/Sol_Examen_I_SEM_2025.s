.data 

# ======================================================
# ESPACIO PARA SOLUCION
# ======================================================

.text 
# ======================================================
# SETUP EJERCICIO DECODIFICADOR DE OPERACIONES (version RISC-V)
# Convertido desde ARM (VisUAL2) - NO RESUELTO
# ======================================================
#
# Tabla de equivalencia de registros usada en esta conversion:
#   ARM R0  ->  RISC-V t0   (inicio del espacio de datos)
#   ARM R1  ->  RISC-V t1   (fin del espacio de datos)
#   ARM R2  ->  RISC-V t2   (inicio del espacio de soluciones)
#   ARM R3  ->  RISC-V t3   (registro de trabajo / valor a almacenar)
#   temp    ->  RISC-V t4   registro auxiliar, necesario porque en RISC-V
#                             "addi" solo admite inmediatos de 12 bits con
#                             signo; los inmediatos grandes de ARM ADD #imm
#                             deben cargarse primero en un registro con "li"
#                             y luego sumarse con "add"
#
# Tabla de equivalencia de instrucciones relevantes para este examen:
#   ARM  MOV Rd, #imm        ->  RISC-V  li   rd, imm
#   ARM  ADD Rd, Rn, #imm    ->  RISC-V  li   temp, imm  /  add rd, rn, temp
#                                 (o addi rd, rn, imm si el inmediato cabe en 12 bits)
#   ARM  BL  etiqueta        ->  RISC-V  jal  ra, etiqueta
#   ARM  MOV PC, LR          ->  RISC-V  ret
#   ARM  STR Rd, [Rn]        ->  RISC-V  sw   rd, 0(rn)
#   ARM  STR Rd, [Rn, #N]    ->  RISC-V  sw   rd, N(rn)
#
# ------------------------------------------------------
# Definicion de Direcciones de Memoria
# Inicio de espacio con datos
li      a0, 0x00FF0000 # registro que guarda la direcci?n de inicio de los datos
# Fin de espacio con datos
li      t4, 0x00000010
add     a1, a0, t4

# Inicio espacio de memoria para soluciones
li      t2, 0x00FF0000

# 1er Valor en Memoria
li      t3, 0xFE000000
li      t4, 0x00AB0000
add     t3, t3, t4
li      t4, 0x00005700
add     t3, t3, t4
li      t4, 0x00000013
add     t3, t3, t4
sw      t3, 0(a0)
 
# 2do Valor en Memoria
li      t3, 0xAC000000
li      t4, 0x00980000
add     t3, t3, t4
li      t4, 0x00000F00
add     t3, t3, t4
li      t4, 0x00000010
add     t3, t3, t4
sw      t3, 4(a0)

# 3er Valor en Memoria
li      t3, 0x05000000
li      t4, 0x00F80000
add     t3, t3, t4
li      t4, 0x00002E00
add     t3, t3, t4
li      t4, 0x00000033
add     t3, t3, t4
sw      t3, 8(a0)

# 4to Valor en Memoria
li      t3, 0x66000000
li      t4, 0x00990000
add     t3, t3, t4
li      t4, 0x00009A00
add     t3, t3, t4
li      t4, 0x000000FF
add     t3, t3, t4
sw      t3, 12(a0)

# 5to Valor en Memoria
li      t3, 0xFE000000
li      t4, 0x00C70000
add     t3, t3, t4
li      t4, 0x00000000
add     t3, t3, t4
li      t4, 0x00000098
add     t3, t3, t4
sw      t3, 16(a0)

    li t0, 0
    li t1, 0 # contador de la posicion de la palabra
    li t3, 0
    li t4, 0
    li t5, 0
    li t6, 0
    li s1, 0
    li s2, 0
    li s3, 0
    li s4, 0
    li s5, 0
    li s7, 8 
    
    li s8, 1 
    li s9, 2 
    li s10, 3
    
    li a3, 17
main:    
    lw t3, 0(a0)
    
    andi t5, t1, 3
    
    beq t5, x0, operacion1 # si el numero es 0 hace operacion  1
    beq t5, s8, operacion2 # si el numero es 1 hace operacion  2
    beq t5, s9, operacion3 # si el numero es 2 hace operacion  3
    beq t5, s10, operacion4 # si el numero es 3 hace operacion  4
    
operacion1:
    
    andi t4, t3, 0xF # el registro t4 guarda los bits 0-7 de 0(t0)
    srli t3, t3, 4 # desplazo a la derecha el registro t3, 10 posiciones y lo guardo en t3
    
    andi t5, t3, 0xF # el registro t5 guarda los bits 8-11 de 0(t0)
    srli t3, t3, 4 # desplazo a la derecha el registro t3, 4 posiciones y lo guardo en t3
    
    andi t6, t3, 0xF # el registro t6 guarda los bits 12-15 de 0(t0)
    srli t3, t3, 4 # desplazo a la derecha el registro t3, 5 posiciones y lo guardo en t3
    
    andi s1, t3, 0xF # el registro s1 guarda los bits 16-19 de 0(t0)
    srli t3, t3, 4 # desplazo a la derecha el registro t3, 11 posiciones y lo guardo en t3

    andi s2, t3, 0xF # el registro s1 guarda los bits 20-23 de 0(t0)
    srli t3, t3, 4 # desplazo a la derecha el registro t3, 11 posiciones y lo guardo en t3

    andi s3, t3, 0xF # el registro s1 guarda los bits 24-27 de 0(t0)
    srli t3, t3, 4 # desplazo a la derecha el registro t3, 11 posiciones y lo guardo en t3

    andi s4, t3, 0xF # el registro s1 guarda los bits 28-31 de 0(t0)
    srli t3, t3, 4 # desplazo a la derecha el registro t3, 11 posiciones y lo guardo en t3

    andi s5, t3, 0xF # el registro s1 guarda los bits 28-31 de 0(t0)
    srli t3, t3, 4 # desplazo a la derecha el registro t3, 11 posiciones y lo guardo en t3

    add t4, t4, t5
    add t4, t4, t6
    add t4, t4, s1
    add t4, t4, s2
    add t4, t4, s3
    add t4, t4, s4
    add t4, t4, s5
    
    sw t4, 0(t2)
    
    li t4, 0
    li t5, 0
    li t6, 0
    li s1, 0
    li s2, 0
    li s3, 0
    li s4, 0
    li s5, 0

    jal x0, continuar
    
operacion2:
    andi t4, t3, 0xFF # el registro t4 guarda los bits 0-7 de 0(t0)
    srli t3, t3, 8 # desplazo a la derecha el registro t3, 10 posiciones y lo guardo en t3
    
    andi t5, t3, 0xFF # el registro t5 guarda los bits 8-15 de 0(t0)
    srli t3, t3, 8 # desplazo a la derecha el registro t3, 4 posiciones y lo guardo en t3
    
    andi t6, t3, 0xFF # el registro t6 guarda los bits 16-23 de 0(t0)
    srli t3, t3, 8 # desplazo a la derecha el registro t3, 5 posiciones y lo guardo en t3
    
    andi s1, t3, 0xFF # el registro s1 guarda los bits 24-31 de 0(t0)
    srli t3, t3, 8 # desplazo a la derecha el registro t3, 11 posiciones y lo guardo en t3

    xor t4, t4, t5
    xor t4, t4, t6
    xor t4, t4, s1
    
    sw t4, 0(t2)
    
    li t4, 0
    li t5, 0
    li t6, 0
    li s1, 0
    
    jal x0, continuar

operacion3:
    andi t4, t3, 0xFF # el registro t4 guarda los bits 0-7 de 0(t0)
    srli t3, t3, 8 # desplazo a la derecha el registro t3, 10 posiciones y lo guardo en t3
    
    andi t5, t3, 0xFF # el registro t5 guarda los bits 8-15 de 0(t0)
    srli t3, t3, 8 # desplazo a la derecha el registro t3, 4 posiciones y lo guardo en t3

    slli t5, t5, 8 # desplazo a la derecha el registro t3, 4 posiciones y lo guardo en t3
    add t4, t4, t5
    
    andi t6, t3, 0xFF # el registro t6 guarda los bits 16-23 de 0(t0)
    srli t3, t3, 8 # desplazo a la derecha el registro t3, 5 posiciones y lo guardo en t3
    
    andi s1, t3, 0xFF # el registro s1 guarda los bits 24-31 de 0(t0)
    srli t3, t3, 8 # desplazo a la derecha el registro t3, 11 posiciones y lo guardo en t3

    slli s1, s1, 8 # desplazo a la derecha el registro t3, 4 posiciones y lo guardo en t3
    add t6, t6, s1
    
    # los registros t6 y t4 tienen las medias palabras
    
    jal ra, multiplicar

    sw t4, 0(t2)
    
    li t4, 0
    li t5, 0
    li t6, 0
    li s1, 0
    
    jal x0, continuar

multiplicar: 
    add t4, t4, t4
    addi s2, s2, 1
    
    beq s2, t6, terminar_mult
    j multiplicar
	
terminar_mult:
    li s2, 0
    
    ret 

dividir: 
    addi t4, t4, -17
    addi s2, s2, 1
    
    blt t4, a3, terminar_div
    j dividir
	
terminar_div:
    li s2, 0
    
    ret 

operacion4:
    add t4, t3, t4 
    jal ra, dividir
    sw s5, 0(t2)
    
    li t4, 0

    jal x0, continuar

continuar: 
    addi t1, t1, 1
    addi t2, t2, 4
    addi a0, a0, 4
    
    beq a0, a1, fin
    
    jal x0, main

fin: 
    jal x0, fin
    
    