# ===============================================================================
# SUITE MAESTRA COMPLETA DE RISC-V (RV32I) PARA RIPES
# Incluye:
# 1. Operaciones Básicas I (Aritmética, Lógica, Desplazamientos, Memoria y Saltos)
# 2. Operaciones Básicas II (Pseudoinstrucciones, Pila, Punteros, Stores B/H/W)
# 3. Módulo Cifrado Feistel (4 Rondes con corrección de rango inmediato)
# 4. Módulo Decodificador de Campos de Bits
# 5. Módulo Bubble Sort Descendente
# 6. Módulo Conteo ASCII y Top 2 Frecuencias
# 7. Módulo Aritmética por Software (Multiplicación y División)
# 8. Módulo Traducción de C (Anexo C)
# ===============================================================================

.data
.align 2

# ===============================================================================
# SECCIÓN UNIFICADA DE SETUP DE DATOS (.data)
# ===============================================================================

# --- DATOS: OPERACIONES BÁSICAS I Y II ---
b_val_a:            .word 42
b_val_b:            .word 15
b_val_negativo:     .word -20
b_val_32bits:       .word 0x12345678
b_val_unsigned1:    .word 0x80000000
b_val_unsigned2:    .word 0x00000005

b_dato_byte:        .byte 0x7F
b_dato_half:        .half 0x1234
b_dato_word:        .word 0x89ABCDEF

.align 2
b_buffer_escritura: .zero 16
b_puntero_funcion:  .word 0

# Resultados Básico
b_res_suma:         .word 0
b_res_resta:        .word 0
b_res_and:          .word 0
b_res_or:           .word 0
b_res_xor:          .word 0
b_res_sll:          .word 0
b_res_srl:          .word 0
b_res_sra:          .word 0
b_res_slt:          .word 0
b_res_negado:       .word 0
b_res_not:          .word 0

# --- DATOS: MÓDULO 1 (FEISTEL) ---
tabla_feistel:      .byte 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
palabra_feistel:    .word 0x12348765
res_feistel:        .word 0

# --- DATOS: MÓDULO 2 (DECODIFICADOR) ---
palabra_codificada: .word 0x05408C00
res_decodificador:  .word 0

# --- DATOS: MÓDULO 3 (BUBBLE SORT) ---
arreglo_origen:     .word 15, 3, 8, 22, 101, 45, 1, 88, 12, 6
.align 2
arreglo_destino:    .zero 40

# --- DATOS: MÓDULO 4 (ASCII TOP 2) ---
cadena_ascii:       .asciz "Examen de Arquitectura RISC-V 2026!"
.align 2
top1_ascii:         .word 0
top2_ascii:         .word 0

# --- DATOS: MÓDULO 5 (ARITMÉTICA SOFT) ---
res_mult:           .word 0
res_div_cociente:   .word 0
res_div_residuo:    .word 0

# --- DATOS: MÓDULO 6 (TRADUCCIÓN C) ---
val_a:              .word 11
val_b:              .word 7
val_op:             .word 0
res_traduccion_c:   .word 0


# ===============================================================================
# SECCIÓN DE CÓDIGO (.text)
# ===============================================================================
.text
.globl main

main:
    # -------------------------------------------------------------------------
    # EJECUCIÓN SECUENCIAL COMPLETA (F5)
    # -------------------------------------------------------------------------
    
    # 1. Operaciones Básicas I
    jal  ra, test_basico_1

    # 2. Operaciones Básicas II (Pseudoinstrucciones, Stores, Pila, JALR)
    jal  ra, test_basico_2

    # 3. Cifrado Feistel
    jal  ra, test_feistel

    # 4. Decodificador de Campos
    jal  ra, test_decodificador

    # 5. Bubble Sort Descendente
    jal  ra, test_bubble_sort

    # 6. Conteo ASCII y Top 2
    jal  ra, test_conteo_ascii

    # 7. Aritmética por Software
    jal  ra, test_aritmetica_soft

    # 8. Traducción de Código C
    jal  ra, test_traduccion_c

    # -------------------------------------------------------------------------
    # FIN DEL PROGRAMA (Syscall Exit)
    # -------------------------------------------------------------------------
    li   a7, 10
    ecall


# ===============================================================================
# IMPLEMENTACIÓN DE MÓDULOS Y SUBRUTINAS
# ===============================================================================

# -------------------------------------------------------------------------------
# BLOQUE BÁSICO 1: ARITMÉTICA, LÓGICA, DESPLAZAMIENTOS, MEMORIA Y BIFURCACIONES
# -------------------------------------------------------------------------------
test_basico_1:
    addi sp, sp, -4
    sw   ra, 0(sp)

    lw   t0, b_val_a
    lw   t1, b_val_b
    lw   t2, b_val_negativo

    # Aritmética
    add  t3, t0, t1
    sub  t4, t0, t1
    addi t5, t0, 10
    la   t6, b_res_suma
    sw   t3, 0(t6)
    la   t6, b_res_resta
    sw   t4, 0(t6)

    # Lógica bit a bit
    and  t3, t0, t1
    or   t4, t0, t1
    xor  t5, t0, t1
    andi s0, t0, 0x0F
    ori  s1, t0, 0x30
    xori s2, t0, -1
    la   t6, b_res_and
    sw   t3, 0(t6)
    la   t6, b_res_or
    sw   t4, 0(t6)
    la   t6, b_res_xor
    sw   t5, 0(t6)

    # Desplazamientos
    slli t3, t0, 2
    srli t4, t0, 1
    srai t5, t2, 2
    la   t6, b_res_sll
    sw   t3, 0(t6)
    la   t6, b_res_srl
    sw   t4, 0(t6)
    la   t6, b_res_sra
    sw   t5, 0(t6)

    # Comparaciones
    slt  t3, t1, t0
    slti t4, t0, 100
    sltu t5, t2, t0
    la   t6, b_res_slt
    sw   t3, 0(t6)

# Cargas de memoria corregidas (Loads por tamaño)
    la   t6, b_dato_byte
    lb   s0, 0(t6)              # Carga 8 bits con signo
    lbu  s1, 0(t6)              # Carga 8 bits sin signo (Línea 182 corregida)

    la   t6, b_dato_half
    lh   s2, 0(t6)              # Carga 16 bits con signo
    lhu  s3, 0(t6)              # Carga 16 bits sin signo (Línea 184 corregida)

    la   t6, b_dato_word
    lw   s4, 0(t6)              # Carga 32 bits

    # Control de flujo
    beq  t0, t1, b1_caso_igual
    bne  t0, t1, b1_caso_distinto
    j    b1_fin

b1_caso_igual:
    addi s5, zero, 0
    j    b1_fin

b1_caso_distinto:
    blt  t1, t0, b1_es_menor
    j    b1_fin

b1_es_menor:
    bge  t0, t1, b1_es_mayor_igual
    j    b1_fin

b1_es_mayor_igual:
    jal  ra, funcion_multiplicar_por_dos

b1_fin:
    lw   ra, 0(sp)
    addi sp, sp, 4
    ret

funcion_multiplicar_por_dos:
    slli a0, t0, 1
    ret


# -------------------------------------------------------------------------------
# BLOQUE BÁSICO 2: PSEUDOINSTRUCCIONES, MANEJO DE PILA, STORES Y PUNTEROS
# -------------------------------------------------------------------------------
test_basico_2:
    addi sp, sp, -4
    sw   ra, 0(sp)

    # Pseudoinstrucciones
    li   t0, 15
    mv   t1, t0
    neg  t2, t0
    not  t3, t0
    nop

    la   t4, b_res_negado
    sw   t2, 0(t4)
    la   t4, b_res_not
    sw   t3, 0(t4)

    # Constantes de 32 bits (LUI + ADDI)
    lui  s0, 0x12345
    addi s0, s0, 0x678

    # Almacenamiento (Stores: Byte, Halfword, Word)
    la   s1, b_buffer_escritura
    li   t0, 0xAB
    sb   t0, 0(s1)
    li   t0, 0xCDEF
    sh   t0, 2(s1)
    li   t0, 0x11223344
    sw   t0, 4(s1)

    # Bifurcaciones Unsigned y Cero
    lw   t0, b_val_negativo
    lw   t1, b_val_unsigned1
    lw   t2, b_val_unsigned2

    beqz zero, b2_es_cero
    nop

b2_es_cero:
    bltz t0, b2_es_negativo
    nop

b2_es_negativo:
    bgtz t2, b2_es_positivo
    nop

b2_es_positivo:
    blt  t0, t2, b2_menor_firmado

b2_menor_firmado:
    bgeu t1, t2, b2_mayor_unsigned

b2_mayor_unsigned:
    # Máscaras de bits
    li   t0, 0b10101010
    ori  t1, t0, 0b00000001
    andi t2, t0, 0b11111101
    xori t3, t0, 0b10000000
    andi t4, t0, 1

    # Manejo de la pila (Stack)
    li   s0, 0xAAAA
    li   s1, 0xBBBB
    addi sp, sp, -8
    sw   s0, 0(sp)
    sw   s1, 4(sp)
    li   s0, 0
    li   s1, 0
    lw   s1, 4(sp)
    lw   s0, 0(sp)
    addi sp, sp, 8

    # Salto indirecto por registro (JALR)
    la   t0, mi_subrutina
    la   t1, b_puntero_funcion
    sw   t0, 0(t1)
    lw   t2, 0(t1)
    jalr ra, t2, 0

    lw   ra, 0(sp)
    addi sp, sp, 4
    ret

mi_subrutina:
    addi a0, zero, 100
    ret


# -------------------------------------------------------------------------------
# 1. CIFRADO FEISTEL
# -------------------------------------------------------------------------------
test_feistel:
    addi sp, sp, -4
    sw   ra, 0(sp)

    la   a0, tabla_feistel
    lw   a2, palabra_feistel
    jal  ra, cifrado_feistel

    la   t0, res_feistel
    sw   a2, 0(t0)

    lw   ra, 0(sp)
    addi sp, sp, 4
    ret

cifrado_feistel:
    addi sp, sp, -12
    sw   ra, 0(sp)
    sw   s0, 4(sp)
    sw   s1, 8(sp)

    srli t0, a2, 16            # t0 = L0
    slli t1, a2, 16
    srli t1, t1, 16            # t1 = R0 (Corrección de máscara de 16 bits)

    li   s0, 0
    li   s1, 4

feistel_loop:
    beq  s0, s1, feistel_fin

    mv   t2, t0
    mv   t0, t1

    li   t3, 0
    li   t4, 0

f_perm_loop:
    li   t5, 16
    beq  t4, t5, f_perm_fin

    add  t5, a0, t4
    lbu  t6, 0(t5)

    srl  a3, t1, t6
    andi a3, a3, 1

    sll  a3, a3, t4
    or   t3, t3, a3

    addi t4, t4, 1
    j    f_perm_loop

f_perm_fin:
    xor  t1, t2, t3
    addi s0, s0, 1
    j    feistel_loop

feistel_fin:
    slli t0, t0, 16
    or   a2, t0, t1

    lw   ra, 0(sp)
    lw   s0, 4(sp)
    lw   s1, 8(sp)
    addi sp, sp, 12
    ret


# -------------------------------------------------------------------------------
# 2. DECODIFICADOR DE CAMPOS
# -------------------------------------------------------------------------------
test_decodificador:
    addi sp, sp, -4
    sw   ra, 0(sp)

    lw   t3, palabra_codificada
    la   t2, res_decodificador
    jal  ra, decodificar_palabra

    lw   ra, 0(sp)
    addi sp, sp, 4
    ret

decodificar_palabra:
    andi t4, t3, 0x3FF
    srli t5, t3, 10
    andi t5, t5, 0xF
    srli t6, t3, 14
    andi t6, t6, 0x1F
    srli a1, t3, 19
    andi a1, a1, 0x7FF

    li   t0, 0
    beq  t5, t0, op_case_0_4
    li   t0, 4
    beq  t5, t0, op_case_0_4

    li   t0, 1
    beq  t5, t0, op_case_1_5
    li   t0, 5
    beq  t5, t0, op_case_1_5

    li   t0, 2
    beq  t5, t0, op_case_2_6
    li   t0, 6
    beq  t5, t0, op_case_2_6

    li   t0, 3
    beq  t5, t0, op_case_3_7
    li   t0, 7
    beq  t5, t0, op_case_3_7

    j    op_case_default

op_case_0_4:
    xor  a0, t4, t6
    and  a0, a0, a1
    j    decod_fin

op_case_1_5:
    sub  a0, t4, t6
    sub  a0, a0, a1
    j    decod_fin

op_case_2_6:
    srl  a0, t4, t6
    sll  a0, a0, a1
    j    decod_fin

op_case_3_7:
    and  a0, a1, t6
    j    decod_fin

op_case_default:
    add  a0, t4, t6
    add  a0, a0, a1

decod_fin:
    sw   a0, 0(t2)
    ret


# -------------------------------------------------------------------------------
# 3. BUBBLE SORT DESCENDENTE
# -------------------------------------------------------------------------------
test_bubble_sort:
    addi sp, sp, -4
    sw   ra, 0(sp)

    la   a0, arreglo_origen
    la   a1, arreglo_destino
    li   a2, 10
    jal  ra, ordenar_descendente

    lw   ra, 0(sp)
    addi sp, sp, 4
    ret

ordenar_descendente:
    addi sp, sp, -12
    sw   ra, 0(sp)
    sw   s0, 4(sp)
    sw   s1, 8(sp)

    li   t0, 0
copiar_loop:
    beq  t0, a2, iniciar_sort
    slli t1, t0, 2
    add  t2, a0, t1
    lw   t3, 0(t2)
    add  t2, a1, t1
    sw   t3, 0(t2)
    addi t0, t0, 1
    j    copiar_loop

iniciar_sort:
    addi s0, a2, -1
    li   t0, 0

outer_loop:
    beq  t0, s0, sort_fin
    li   t1, 0
    sub  t2, s0, t0

inner_loop:
    beq  t1, t2, next_outer
    slli t3, t1, 2
    add  t3, a1, t3
    lw   s1, 0(t3)
    lw   a3, 4(t3)

    bge  s1, a3, no_swap
    sw   a3, 0(t3)
    sw   s1, 4(t3)

no_swap:
    addi t1, t1, 1
    j    inner_loop

next_outer:
    addi t0, t0, 1
    j    outer_loop

sort_fin:
    lw   ra, 0(sp)
    lw   s0, 4(sp)
    lw   s1, 8(sp)
    addi sp, sp, 12
    ret


# -------------------------------------------------------------------------------
# 4. CONTEO ASCII Y TOP 2
# -------------------------------------------------------------------------------
test_conteo_ascii:
    addi sp, sp, -4
    sw   ra, 0(sp)

    la   a0, cadena_ascii
    jal  ra, conteo_caracteres

    la   t0, top1_ascii
    sw   s4, 0(t0)
    la   t0, top2_ascii
    sw   s5, 0(t0)

    lw   ra, 0(sp)
    addi sp, sp, 4
    ret

conteo_caracteres:
    addi sp, sp, -108
    sw   ra, 104(sp)

    li   t0, 0
limpiar_pila:
    li   t1, 26
    beq  t0, t1, procesar_cadena
    slli t2, t0, 2
    add  t2, sp, t2
    sw   zero, 0(t2)
    addi t0, t0, 1
    j    limpiar_pila

procesar_cadena:
    mv   t0, a0

cadena_loop:
    lbu  t1, 0(t0)
    beq  t1, zero, buscar_top2

    li   t2, 97
    li   t3, 122
    blt  t1, t2, check_mayus
    bgt  t1, t3, check_mayus
    addi t1, t1, -32

check_mayus:
    li   t2, 65
    li   t3, 90
    blt  t1, t2, byte_sig
    bgt  t1, t3, byte_sig

    sub  t4, t1, t2
    slli t4, t4, 2
    add  t4, sp, t4
    lw   t5, 0(t4)
    addi t5, t5, 1
    sw   t5, 0(t4)

byte_sig:
    addi t0, t0, 1
    j    cadena_loop

buscar_top2:
    li   a0, -1
    li   a1, -1
    li   s4, 65
    li   s5, 65
    li   t0, 0

loop_max:
    li   t1, 26
    beq  t0, t1, fin_top2
    slli t2, t0, 2
    add  t2, sp, t2
    lw   t3, 0(t2)

    ble  t3, a0, comp_max2
    mv   a1, a0
    mv   s5, s4
    mv   a0, t3
    addi s4, t0, 65
    j    next_letra

comp_max2:
    ble  t3, a1, next_letra
    mv   a1, t3
    addi s5, t0, 65

next_letra:
    addi t0, t0, 1
    j    loop_max

fin_top2:
    lw   ra, 104(sp)
    addi sp, sp, 108
    ret


# -------------------------------------------------------------------------------
# 5. ARITMÉTICA SOFT
# -------------------------------------------------------------------------------
test_aritmetica_soft:
    addi sp, sp, -4
    sw   ra, 0(sp)

    # Multiplicación: 12 * 9
    li   a0, 12
    li   a1, 9
    jal  ra, multiplicar_soft
    la   t0, res_mult
    sw   a0, 0(t0)

    # División: 108 / 10
    li   a0, 108
    li   a1, 10
    jal  ra, division_soft
    la   t0, res_div_cociente
    sw   a0, 0(t0)
    la   t0, res_div_residuo
    sw   a1, 0(t0)

    lw   ra, 0(sp)
    addi sp, sp, 4
    ret

multiplicar_soft:
    li   t0, 0
    li   t1, 0
mul_loop:
    beq  t1, a1, mul_fin
    add  t0, t0, a0
    addi t1, t1, 1
    j    mul_loop
mul_fin:
    mv   a0, t0
    ret

division_soft:
    li   t0, 0
div_loop:
    blt  a0, a1, div_fin
    sub  a0, a0, a1
    addi t0, t0, 1
    j    div_loop
div_fin:
    mv   a1, a0
    mv   a0, t0
    ret


# -------------------------------------------------------------------------------
# 6. TRADUCCIÓN DE C
# -------------------------------------------------------------------------------
test_traduccion_c:
    addi sp, sp, -4
    sw   ra, 0(sp)

    lw   a0, val_a
    lw   a1, val_b
    lw   a2, val_op
    jal  ra, operaciones_c

    la   t0, res_traduccion_c
    sw   a0, 0(t0)

    lw   ra, 0(sp)
    addi sp, sp, 4
    ret

corrimiento_c:
    sll  a0, a0, a1
    ret

operaciones_c:
    addi sp, sp, -8
    sw   ra, 0(sp)
    sw   s0, 4(sp)

    li   t0, 0
    beq  a2, t0, op_c_0
    li   t0, 1
    beq  a2, t0, op_c_1
    li   t0, 2
    beq  a2, t0, op_c_2

    li   a0, 0
    j    op_c_exit

op_c_0:
    add  a0, a0, a1
    j    op_c_exit

op_c_1:
    and  a0, a0, a1
    j    op_c_exit

op_c_2:
    jal  ra, corrimiento_c

op_c_exit:
    lw   ra, 0(sp)
    lw   s0, 4(sp)
    addi sp, sp, 8
    ret