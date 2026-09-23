# ======================================================
# SETUP EJERCICIO ROTACION (version RISC-V)
# Convertido desde ARM (VisUAL2) - NO RESUELTO
# ======================================================
#
# Tabla de equivalencia de registros usada en esta conversion:
#   ARM R1  ->  RISC-V a1   (direccion de Operando1)
#   ARM R2  ->  RISC-V a2   (direccion de Operando2)
#   ARM R3  ->  RISC-V a3   (direccion de Resultado)
#   ARM R4  ->  RISC-V t0   (registro de trabajo / valor a almacenar)
#
# Tabla de equivalencia de instrucciones relevantes:
#   ARM  MOV Rd, #imm        ->  RISC-V  li   rd, imm
#   ARM  MOV Rd, Rn           ->  RISC-V  mv   rd, rn
#   ARM  ADD Rd, Rn, #imm    ->  RISC-V  addi rd, rn, imm   (si imm cabe en 12 bits)
#   ARM  STR Rd, [Rn]        ->  RISC-V  sw   rd, 0(rn)
#
# ------------------------------------------------------
# Definicion de Direcciones de Memoria
# Direccion Operando1
li      a1, 0x00FF0000

# Direccion Operando2
li      a2, 0x00FF0000
addi    a2, a2, 4

# Direccion Resultado
mv      a3, a1
addi    a3, a3, 8

# Creacion y almacenamiento de Operando1
li      t0, 0x00D80000
addi    t0, t0, 0xBF
sw      t0, 0(a1)

# Creacion y almacenamiento Operando2
li      t0, 25
sw      t0, 0(a2)

# Reinicio de registros segun necesidades del
# ejercicio
li      t0, 0

# ======================================================
# ESPACIO PARA SOLUCION
# ======================================================

