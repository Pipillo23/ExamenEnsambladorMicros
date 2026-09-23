# ======================================================
# SETUP EJERCICIO POTENCIAS Y DIVISIONES (version RISC-V)
# Convertido desde ARM (VisUAL2) - NO RESUELTO
# ======================================================
#
# Tabla de equivalencia de registros usada en esta conversion:
#   ARM R0  ->  RISC-V t0   (direccion base de almacenamiento)
#   ARM R1  ->  RISC-V t1   (operando)
#   ARM R2  ->  RISC-V t2   (operando)
#   ARM R3  ->  RISC-V t3   (operando)
#   ARM R4  ->  RISC-V t4   (operando)
#   ARM R5  ->  RISC-V t5   (operando)
#   ARM R6  ->  RISC-V t6   (operando)
#
# Tabla de equivalencia de instrucciones relevantes para este examen:
#   ARM  MOV Rd, #imm        ->  RISC-V  li   rd, imm
#   ARM  BL  etiqueta        ->  RISC-V  jal  ra, etiqueta   (guarda direccion de retorno en ra)
#   ARM  MOV PC, LR          ->  RISC-V  ret                 (equivalente a jalr x0, 0(ra))
#   ARM  STR Rd, [Rn]        ->  RISC-V  sw   rd, 0(rn)
#   ARM  STR Rd, [Rn, #N]    ->  RISC-V  sw   rd, N(rn)
#   ARM  ADD Rd, Rn, #imm    ->  RISC-V  addi rd, rn, imm
#
# ------------------------------------------------------
# Definicion de Direcciones de Memoria
li      t0, 0x00FF0000

# Valor de Registros como operandos de las operaciones
li      t1, 9
li      t2, 5
li      t3, 80
li      t4, 10
li      t5, 99
li      t6, 0

# ======================================================
# ESPACIO PARA SOLUCION
# ======================================================

