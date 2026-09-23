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
li      t0, 0x00FF0000 # registro que guarda la direcci?n de inicio de los datos
# Fin de espacio con datos
li      t4, 0x00000010
add     t1, t0, t4

# Inicio espacio de memoria para soluciones
li      t2, 0x00AA0000

# 1er Valor en Memoria
li      t3, 0xFE000000
li      t4, 0x00AB0000
add     t3, t3, t4
li      t4, 0x00005700
add     t3, t3, t4
li      t4, 0x00000013
add     t3, t3, t4
sw      t3, 0(t0)

# 2do Valor en Memoria
li      t3, 0xAC000000
li      t4, 0x00980000
add     t3, t3, t4
li      t4, 0x00000F00
add     t3, t3, t4
li      t4, 0x00000010
add     t3, t3, t4
sw      t3, 4(t0)

# 3er Valor en Memoria
li      t3, 0x05000000
li      t4, 0x00F80000
add     t3, t3, t4
li      t4, 0x00002E00
add     t3, t3, t4
li      t4, 0x00000033
add     t3, t3, t4
sw      t3, 8(t0)

# 4to Valor en Memoria
li      t3, 0x66000000
li      t4, 0x00990000
add     t3, t3, t4
li      t4, 0x00009A00
add     t3, t3, t4
li      t4, 0x000000FF
add     t3, t3, t4
sw      t3, 12(t0)

# 5to Valor en Memoria
li      t3, 0xFE000000
li      t4, 0x00C70000
add     t3, t3, t4
li      t4, 0x00000000
add     t3, t3, t4
li      t4, 0x00000098
add     t3, t3, t4
sw      t3, 16(t0)

    li t3, 0
    li t4, 0
    li t5, 0
    li t6, 0
    li s1, 0
    li s2, 0
    li s3, 0
    li s4, 1 # constante 1
    li s5, 0
    li s6, 5 # contador de palabras
    li s7, 8 
    li s8, 1 
    li s9, 2 
    li s10, 3
    li s11, 4 
    li a1, 5 
    li a2, 6 
    li a3, 7 
    
main:    
    lw t3, 0(t0)
    andi t4, t3, 0x3FF # el registro t4 guarda los bits 0-9 de 0(t0)
    srli t3, t3, 10 # desplazo a la derecha el registro t3, 10 posiciones y lo guardo en t3
    
    andi t5, t3, 0xF # el registro t5 guarda los bits 10-13 de 0(t0)
    srli t3, t3, 4 # desplazo a la derecha el registro t3, 4 posiciones y lo guardo en t3
    
    andi t6, t3, 0x1F # el registro t6 guarda los bits 14-18 de 0(t0)
    srli t3, t3, 5 # desplazo a la derecha el registro t3, 5 posiciones y lo guardo en t3
    
    andi s1, t3, 0x7FF # el registro s1 guarda los bits 19-29 de 0(t0)
    srli t3, t3, 11 # desplazo a la derecha el registro t3, 11 posiciones y lo guardo en t3

    # con estas operaciones ya tengo los 29 bits que ocupo
    
    bge t5, s7, operacion5 # si el numero es mayor a 8, hace operaci?n 5
    
    beq t5, x0, operacion1 # si el numero es 0 hace operacion  1
    beq t5, s8, operacion2 # si el numero es 1 hace operacion  2
    beq t5, s9, operacion3 # si el numero es 2 hace operacion  3
    beq t5, s10, operacion4 # si el numero es 3 hace operacion  4
    beq t5, s11, operacion1 # si el numero es 4 hace operacion  1
    beq t5, a1, operacion2 # si el numero es 5 hace operacion  2
    beq t5, a2, operacion3 # si el numero es 6 hace operacion  3
    beq t5, a3, operacion4 # si el numero es 7 hace operacion  4

    
operacion1:
     xor s5, t4, t6
     and s5, s5, s1
     sw s5, 0(t2)
    
    jal x0, continuar
    
operacion2:
     sub s5, t4, t6
     sub s5, s5, s1
     sw s5, 0(t2)
    
    jal x0, continuar

operacion3:
     srl s5, t4, t6
     sll s5, s5, s1
     sw s5, 0(t2)
    
    jal x0, continuar

operacion4:
     and s5, s1, t6
     sw s5, 0(t2)
    
    jal x0, continuar

operacion5:
     add s5, t4, t6
     add s5, s5, s1
     sw s5, 0(t2)
    
    jal x0, continuar


continuar: 
    addi t2, t2, 4
    addi t0, t0, 4
    addi s6, s6, -1
    
    beq s6, x0, fin
    
    jal x0, main

fin: 
    jal x0, fin
    
    