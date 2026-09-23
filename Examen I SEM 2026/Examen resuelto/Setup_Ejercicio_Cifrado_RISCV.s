# ======================================================
# SETUP EJERCICIO CIFRADO (version RISC-V)
# Convertido desde ARM (VisUAL2) - NO RESUELTO
# ======================================================
#
# Tabla de equivalencia de registros usada en esta conversion:
#   ARM R0  ->  RISC-V a0   (direccion base de la tabla de permutacion, 0x00FF0000)
#   ARM R2  ->  RISC-V a2   (palabra a cifrar / registro de trabajo)
#   (temp)  ->  RISC-V t0   (registro auxiliar para inmediatos de 32 bits;
#                             "addi" solo admite 12 bits con signo)
#
# ------------------------------------------------------
# Definicion de Direccion de Memoria
li      a0, 0x00FF0000

# Creacion y almacenamiento de la tabla de permutacion
li      a2, 0x07000000
li      t0, 0x00090000
add     a2, a2, t0
li      t0, 0x00000A00
add     a2, a2, t0
addi    a2, a2, 0x0
sw      a2, 0(a0)

li      a2, 0x05000000
li      t0, 0x000D0000
add     a2, a2, t0
li      t0, 0x00000E00
add     a2, a2, t0
addi    a2, a2, 0x8
sw      a2, 4(a0)

li      a2, 0x01000000
li      t0, 0x000B0000
add     a2, a2, t0
addi    a2, a2, 0x600
addi    a2, a2, 0x4
sw      a2, 8(a0)

li      a2, 0x02000000
li      t0, 0x00030000
add     a2, a2, t0
li      t0, 0x00000C00
add     a2, a2, t0
addi    a2, a2, 0xF
sw      a2, 12(a0)

# Reinicio de registros segun necesidades del
# ejercicio
li      a2, 0xFB000000
li      t0, 0x00D70000
add     a2, a2, t0
li      t0, 0x00006800
add     a2, a2, t0
addi    a2, a2, 0x12

# ======================================================
# ESPACIO PARA SOLUCION
# ======================================================

