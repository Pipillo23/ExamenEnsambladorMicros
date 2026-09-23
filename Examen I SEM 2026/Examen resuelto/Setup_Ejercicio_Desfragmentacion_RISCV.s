# ======================================================
# SETUP EJERCICIO DESFRAGMENTACION (version RISC-V)
# Convertido desde ARM (VisUAL2) - NO RESUELTO
# ======================================================
#
# Tabla de equivalencia de registros usada en esta conversion:
#   ARM R0  ->  RISC-V a0   (direccion inicial del bloque de memoria)
#   ARM R1  ->  RISC-V a1   (contador / direccion final del bloque, al terminar el header)
#   ARM R2  ->  RISC-V a2   (palabra vacio 0xDEADDEAD)
#   ARM R3  ->  RISC-V a3   (valor de dato "real" a almacenar, se incrementa)
#   ARM R4  ->  RISC-V a4   (resultado de AND, usado para decidir vacio/real)
#   (temp)  ->  RISC-V t0, t1  (registros auxiliares: comparaciones e inmediatos
#                                 grandes, y direccion efectiva a0+a1 para STR)
#
# Tabla de equivalencia de instrucciones relevantes:
#   ARM  MOV Rd, #imm             ->  RISC-V  li   rd, imm
#   ARM  ADD Rd, Rn, #imm         ->  RISC-V  addi rd, rn, imm
#   ARM  SUB Rd, Rn, #imm         ->  RISC-V  addi rd, rn, -imm
#   ARM  AND Rd, Rn, #imm         ->  RISC-V  andi rd, rn, imm
#   ARM  CMP Rn, #imm / BEQ lbl   ->  RISC-V  li temp, imm  /  beq rn, temp, lbl
#   ARM  CMP Rn, #imm / STREQ..   ->  RISC-V  li temp, imm  /  bne rn, temp, lbl_else
#                                       (bloque "then" del STREQ, salto sobre el "else")
#   ARM  STRNE / ADDNE            ->  RISC-V  bloque "else" alcanzado si no son iguales
#   ARM  B etiqueta               ->  RISC-V  j etiqueta
#   ARM  STR Rd, [Rn, Rm]         ->  RISC-V  add temp, rn, rm  /  sw rd, 0(temp)
#
# ------------------------------------------------------
# Definicion de Variables Iniciales
li      a0, 0x00FF0000
li      a1, 0
li      a3, 0x99

# Creacion palabra vacio 0xDEADDEAD
li      a2, 0xDE000000
li      t1, 0x00AD0000
add     a2, a2, t1
li      t1, 0x0000DE00
add     a2, a2, t1
li      t1, 0x000000AD
add     a2, a2, t1

# Creacion y almacenamiento memoria fragmentada
FRAGMENTADA_1:
li      t0, 0x60
beq     a1, t0, FRAGMENTADA_2

# Decide entre almacenar valor real o vacio
andi    a4, a1, 0x4
li      t0, 4
bne     a4, t0, FRAG1_REAL
add     t1, a0, a1
sw      a2, 0(t1)
j       FRAG1_SIGUIENTE
FRAG1_REAL:
add     t1, a0, a1
sw      a3, 0(t1)
addi    a3, a3, 1
FRAG1_SIGUIENTE:
addi    a1, a1, 4
j       FRAGMENTADA_1

FRAGMENTADA_2:
li      t0, 0x120
beq     a1, t0, REINICIO

# Decide entre almacenar valor real o vacio
andi    a4, a1, 0x8
li      t0, 8
bne     a4, t0, FRAG2_REAL
add     t1, a0, a1
sw      a2, 0(t1)
j       FRAG2_SIGUIENTE
FRAG2_REAL:
add     t1, a0, a1
sw      a3, 0(t1)
addi    a3, a3, 1
FRAG2_SIGUIENTE:
addi    a1, a1, 4
j       FRAGMENTADA_2

# Reinicio de registros segun necesidades del
# ejercicio
REINICIO:
add     a1, a0, a1
addi    a1, a1, -4
li      a2, 0
li      a3, 0
li      a4, 0

# ======================================================
# ESPACIO PARA SOLUCION
# ======================================================

