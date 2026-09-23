# ======================================================
# SETUP EJERCICIO SECUENCIA DE OPERACIONES (version RISC-V)
# Convertido desde ARM (VisUAL2) - NO RESUELTO
# ======================================================
#
# Tabla de equivalencia de registros usada en esta conversion:
#   ARM R0  ->  RISC-V a0   (direccion inicial del espacio de memoria)
#   ARM R1  ->  RISC-V a1   (direccion final del espacio de memoria)
#   ARM R2  ->  RISC-V a2   (registro de trabajo / valor a almacenar)
#   (temp)  ->  RISC-V t0   (registro auxiliar, necesario porque en RISC-V
#                             "addi" solo admite inmediatos de 12 bits con
#                             signo; los inmediatos grandes de ARM ADD #imm
#                             deben cargarse primero en un registro con "li"
#                             y luego sumarse con "add")
#
# Tabla de equivalencia de instrucciones relevantes para este examen:
#   ARM  MOV Rd, #imm        ->  RISC-V  li   rd, imm
#   ARM  ADD Rd, Rn, #imm    ->  RISC-V  addi rd, rn, imm   (si imm cabe en 12 bits con signo)
#                                 RISC-V  li   temp, imm  /  add rd, rn, temp   (si no cabe)
#   ARM  BL  etiqueta        ->  RISC-V  jal  ra, etiqueta
#   ARM  MOV PC, LR          ->  RISC-V  ret
#   ARM  STR Rd, [Rn]        ->  RISC-V  sw   rd, 0(rn)
#   ARM  STR Rd, [Rn, #N]    ->  RISC-V  sw   rd, N(rn)
#
# ------------------------------------------------------
# Definicion de Direcciones de Memoria
li      a0, 0x00AA0000
li      a1, 0x00AA0000
addi    a1, a1, 36

# Creacion y almacenamiento del primer dato
li      a2, 0x12000000
li      t0, 0x00340000
add     a2, a2, t0
li      t0, 0x00005600
add     a2, a2, t0
addi    a2, a2, 0x78
sw      a2, 0(a0)

# Creacion y almacenamiento del segundo dato
li      a2, 0xAB000000
li      t0, 0x00C90000
add     a2, a2, t0
li      t0, 0x00001100
add     a2, a2, t0
addi    a2, a2, 0x76
sw      a2, 4(a0)

# Creacion y almacenamiento del tercer dato
li      a2, 0x00BB0000
addi    a2, a2, 0xDD
sw      a2, 8(a0)

# Creacion y almacenamiento del cuarto dato
li      a2, 0x00000077
sw      a2, 12(a0)

# Creacion y almacenamiento del quinto dato
li      a2, 0x9A000000
li      t0, 0x00BC0000
add     a2, a2, t0
li      t0, 0x0000DE00
add     a2, a2, t0
addi    a2, a2, 0xF0
sw      a2, 16(a0)

# Creacion y almacenamiento del sexto dato
li      a2, 0x01000000
li      t0, 0x00020000
add     a2, a2, t0
addi    a2, a2, 0x300
addi    a2, a2, 0x4
sw      a2, 20(a0)

# Creacion y almacenamiento del septimo dato
li      a2, 0x00FF0000
addi    a2, a2, 0xFF
sw      a2, 24(a0)

# Creacion y almacenamiento del octavo dato
li      a2, 0x00000050
sw      a2, 28(a0)

# Reinicio de registros segun necesidades del
# ejercicio
li      a2, 0

# ======================================================
# ESPACIO PARA SOLUCION
# ======================================================

