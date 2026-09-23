# ======================================================
# SETUP EJERCICIO ORDENAR PALABRAS (version RISC-V RV32I)
# Convertido desde ARM (VisUAL2) - NO RESUELTO
# ======================================================
#
# Tabla de equivalencia de registros usada en esta conversion:
#   ARM R0  ->  RISC-V a0 (x10)  direccion inicial del espacio de memoria
#   ARM R2  ->  RISC-V t0        registro de trabajo / valor a almacenar
#
# ------------------------------------------------------
# Definicion de Direcciones de Memoria
li      a0, 0x00FF0000

# Creacion y almacenamiento del primer dato
li      t0, 0x00000082
sw      t0, 0(a0)

# Creacion y almacenamiento del segundo dato
li      t0, 0x00000099
sw      t0, 4(a0)

# Creacion y almacenamiento del tercer dato
li      t0, 0x00000077
sw      t0, 8(a0)

# Creacion y almacenamiento del cuarto dato
li      t0, 0x00000005
sw      t0, 12(a0)

# Creacion y almacenamiento del quinto dato
li      t0, 0x00000020
sw      t0, 16(a0)

# Creacion y almacenamiento del sexto dato
li      t0, 0x00000010
sw      t0, 20(a0)

# Creacion y almacenamiento del septimo dato
li      t0, 0x00000001
sw      t0, 24(a0)

# Creacion y almacenamiento del octavo dato
li      t0, 0x00000033
sw      t0, 28(a0)

# Creacion y almacenamiento del noveno dato
li      t0, 0x00000050
sw      t0, 32(a0)

# Creacion y almacenamiento del decimo dato
li      t0, 0x00000063
sw      t0, 36(a0)

# Reinicio de registros segun necesidades del ejercicio
li      t0, 0

# ======================================================
# ESPACIO PARA SOLUCION
# ======================================================

