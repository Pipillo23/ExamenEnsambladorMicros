.data
.text

# -- Direcciones de memoria ------------------------------
# 0x00FF0004 ? resultado divisi?n    (t3/t4)
# 0x00FF0008 ? resultado multiplicaci?n (t5*t6)
# 0x00FF000C ? resultado exponenciaci?n (t1^t2)

li t0, 0x00FF0000

# -- Operandos ------------------------------------------
li t1, 9     # base para exponenciaci?n
li t2, 5     # exponente
li t3, 80    # dividendo
li t4, 10    # divisor
li t5, 99    # multiplicando A
li t6, 2     # multiplicando B

# -- Variables auxiliares --------------------------------
li s1, 0     # contador interno de multiplicaci?n
li s2, 0     # acumulador de multiplicaci?n
li s3, 0     # cociente de divisi?n
li s4, 0     # contador de exponenciaci?n
li s5, 0     # resultado temporal exponenciaci?n

# ======================================================
# MAIN
# ======================================================
main:
    jal ra, division           # t3/t4  ? mem[0x00FF0004]
    jal ra, multiplicacion_t5t6 # t5*t6 ? mem[0x00FF0008]
    jal ra, exponenciacion     # t1^t2  ? mem[0x00FF000C]
    j   fin

# ======================================================
# DIVISI?N: t3 / t4  (solo cociente)
# Usa: t3 (se modifica), s3 (cociente)
# ======================================================
division:
    li  s3, 0                  # cociente = 0
div_loop:
    sub t3, t3, t4             # dividendo -= divisor
    blt t3, x0, div_fin        # si resultado < 0, terminamos
    addi s3, s3, 1             # cociente++
    j   div_loop
div_fin:
    sw  s3, 4(t0)              # guardar cociente en mem[base+4]
    ret

# ======================================================
# MULTIPLICACI?N GEN?RICA: a0 * a1 ? a0
# Entrada:  a0 = multiplicando, a1 = multiplicador
# Salida:   a0 = resultado
# Preserva: ra (no llama a nadie m?s)
# ======================================================
multiplicacion:
    li  s1, 0                  # contador = 0
    li  s2, 0                  # acumulador = 0
mul_loop:
    beq s1, a1, mul_fin        # si contador == multiplicador, terminamos
    add s2, s2, a0             # acumulador += a0
    addi s1, s1, 1             # contador++
    j   mul_loop
mul_fin:
    mv  a0, s2                 # resultado en a0
    ret

# ======================================================
# MULTIPLICACI?N t5 * t6  (wrapper para guardar en memoria)
# ======================================================
multiplicacion_t5t6:
    addi sp, sp, -4            # guardar ra en la pila porque
    sw   ra, 0(sp)             # vamos a llamar a multiplicacion

    mv  a0, t5                 # a0 = t5 (99)
    mv  a1, t6                 # a1 = t6 (2)
    jal ra, multiplicacion     # a0 = t5 * t6

    sw  a0, 8(t0)              # guardar resultado en mem[base+8]

    lw  ra, 0(sp)              # restaurar ra
    addi sp, sp, 4
    ret

# ======================================================
# EXPONENCIACI?N: t1^t2 ? mem[base+12]
# M?todo: multiplicaci?n repetida
#   resultado = 1
#   repetir t2 veces: resultado = resultado * t1
# ======================================================
exponenciacion:
    addi sp, sp, -4            # guardar ra (vamos a llamar a multiplicacion)
    sw   ra, 0(sp)

    li  s4, 0                  # contador de iteraciones = 0
    li  s5, 1                  # resultado = 1  (a^0 = 1)

exp_loop:
    beq s4, t2, exp_fin        # si contador == exponente, terminamos

    mv  a0, s5                 # a0 = resultado acumulado
    mv  a1, t1                 # a1 = base
    jal ra, multiplicacion     # a0 = resultado * base

    mv  s5, a0                 # actualizar resultado
    addi s4, s4, 1             # contador++
    j   exp_loop

exp_fin:
    sw  s5, 12(t0)             # guardar en mem[base+12]

    lw  ra, 0(sp)              # restaurar ra
    addi sp, sp, 4
    ret

# ======================================================
fin:
    j fin