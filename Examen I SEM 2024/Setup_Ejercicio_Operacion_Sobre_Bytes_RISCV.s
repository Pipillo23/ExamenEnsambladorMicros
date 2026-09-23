# ======================================================
# SETUP EJERCICIO OPERACION SOBRE BYTES (version RISC-V)
# Convertido desde ARM (VisUAL2) - NO RESUELTO
# ======================================================
#
# Tabla de equivalencia de registros usada en esta conversion:
#   ARM R0  ->  RISC-V a0   (direccion inicial del espacio de memoria)
#   ARM R1  ->  RISC-V a1   (direccion final del espacio de memoria, inclusive)
#   ARM R2  ->  RISC-V a2   (registro de trabajo / valor a almacenar)
#   (temp)  ->  RISC-V t0   (registro auxiliar para inmediatos de 32 bits;
#                             "addi" solo admite 12 bits con signo)
#
# ------------------------------------------------------
# Definicion de Direcciones de Memoria
li      a0, 0x00FF0000
li      a1, 0x00FF0000
addi    a1, a1, 0x14

# Creacion y almacenamiento del primer dato
li      a2, 0x55000000
li      t0, 0x00400000
add     a2, a2, t0
li      t0, 0x00002D00
add     a2, a2, t0
addi    a2, a2, 0xAA
sw      a2, 0(a0)

# Creacion y almacenamiento del segundo dato
li      a2, 0x07000000
li      t0, 0x00070000
add     a2, a2, t0
addi    a2, a2, 0x200
addi    a2, a2, 0x3
sw      a2, 4(a0)

# Creacion y almacenamiento del tercer dato
li      a2, 0x99000000
li      t0, 0x00770000
add     a2, a2, t0
li      t0, 0x00001500
add     a2, a2, t0
addi    a2, a2, 0xFA
sw      a2, 8(a0)

# Creacion y almacenamiento del cuarto dato
li      a2, 0x0A000000
li      t0, 0x000B0000
add     a2, a2, t0
li      t0, 0x00000C00
add     a2, a2, t0
addi    a2, a2, 0xD
sw      a2, 12(a0)

# Creacion y almacenamiento del quinto dato
li      a2, 0xFF000000
li      t0, 0x0000AB00
add     a2, a2, t0
addi    a2, a2, 0x2
sw      a2, 16(a0)

# Creacion y almacenamiento del sexto dato
li      a2, 0xCA000000
li      t0, 0x00FE0000
add     a2, a2, t0
li      t0, 0x0000BE00
add     a2, a2, t0
addi    a2, a2, 0xFF
sw      a2, 20(a0)

# Reinicio de registros segun necesidades del
# ejercicio
li      a2, 0

# ======================================================
# ESPACIO PARA SOLUCION
# ======================================================

