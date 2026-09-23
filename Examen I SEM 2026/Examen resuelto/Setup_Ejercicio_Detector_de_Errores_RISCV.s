# ======================================================
# SETUP EJERCICIO DETECTOR DE ERRORES (version RISC-V)
# Convertido desde ARM (VisUAL2) - NO RESUELTO
# ======================================================
#
# Tabla de equivalencia de registros usada en esta conversion:
#   ARM R0  ->  RISC-V a0   (direccion inicial del espacio de memoria)
#   ARM R1  ->  RISC-V a1   (direccion final del espacio de memoria, inclusive)
#   ARM R2  ->  RISC-V a2   (cantidad de instrucciones correctas - resultado)
#   ARM R3  ->  RISC-V a3   (cantidad de instrucciones incorrectas - resultado)
#   (temp)  ->  RISC-V t0   (registro auxiliar para inmediatos de 32 bits;
#                             "addi" solo admite 12 bits con signo)
#
# ------------------------------------------------------
# Definicion de Direcciones de Memoria
li      a0, 0x00FF0000
li      a1, 0x00FF0000
addi    a1, a1, 0x10

# Creacion y almacenamiento del primer dato
li      a2, 0x7C000000
li      t0, 0x00240000
add     a2, a2, t0
li      t0, 0x0000C900
add     a2, a2, t0
addi    a2, a2, 0xA0
sw      a2, 0(a0)

# Creacion y almacenamiento del segundo dato
li      a2, 0xFA000000
li      t0, 0x00440000
add     a2, a2, t0
li      t0, 0x00005A00
add     a2, a2, t0
addi    a2, a2, 0xA4
sw      a2, 4(a0)

# Creacion y almacenamiento del tercer dato
li      a2, 0xE3000000
li      t0, 0x00F00000
add     a2, a2, t0
li      t0, 0x00007E00
add     a2, a2, t0
addi    a2, a2, 0x25
sw      a2, 8(a0)

# Creacion y almacenamiento del cuarto dato
li      a2, 0x08000000
li      t0, 0x00CA0000
add     a2, a2, t0
li      t0, 0x00005900
add     a2, a2, t0
addi    a2, a2, 0x40
sw      a2, 12(a0)

# Creacion y almacenamiento del quinto dato
li      a2, 0x64000000
li      t0, 0x00AF0000
add     a2, a2, t0
li      t0, 0x00001900
add     a2, a2, t0
addi    a2, a2, 0x5C
sw      a2, 16(a0)

# Reinicio de registros segun necesidades del
# ejercicio
li      a2, 0

# ======================================================
# ESPACIO PARA SOLUCION
# ======================================================

