# ===============================================================================
# PLANTILLA SECUENCIAL MAESTRA DE EXÁMENES EN RISC-V (RV32I) PARA RIPES
# Este archivo ejecuta TODOS los módulos de manera consecutiva al presionar Run (F5).
# ===============================================================================

.data
.align 2

# --- DATOS MÓDULO 1: CIFRADO FEISTEL ---
tabla_feistel:      .byte 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
palabra_feistel:    .word 0x12348765
res_feistel:        .word 0

# --- DATOS MÓDULO 2: DECODIFICADOR DE CAMPOS ---
palabra_codificada: .word 0x05408C00
res_decodificador:  .word 0

# --- DATOS MÓDULO 3: BUBBLE SORT DESCENDENTE ---
arreglo_origen:     .word 15, 3, 8, 22, 101, 45, 1, 88, 12, 6
.align 2
arreglo_destino:    .zero 40            # Espacio reservado para 10 palabras (40 bytes)

# --- DATOS MÓDULO 4: CONTEO ASCII Y TOP 2 ---
cadena_ascii:       .asciz "Examen de Arquitectura RISC-V 2026!"
.align 2
top1_ascii:         .word 0
top2_ascii:         .word 0

# --- DATOS MÓDULO 5: ARITMÉTICA SOFT ---
res_mult:           .word 0
res_div_cociente:   .word 0
res_div_residuo:    .word 0

# --- DATOS MÓDULO 6: TRADUCCIÓN C (ANEXO C) ---
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
    # EJECUCIÓN SECUENCIAL DE TODOS LOS MÓDULOS
    # -------------------------------------------------------------------------
    
    # 1. Ejecutar Cifrado Feistel
    jal  ra, test_feistel

    # 2. Ejecutar Decodificador de Campos de Bits
    jal  ra, test_decodificador

    # 3. Ejecutar Bubble Sort Descendente
    jal  ra, test_bubble_sort

    # 4. Ejecutar Conteo de Caracteres y Top 2 ASCII
    jal  ra, test_conteo_ascii

    # 5. Ejecutar Aritmética por Software (Multiplicación y División)
    jal  ra, test_aritmetica_soft

    # 6. Ejecutar Traducción de Código C (Anexo C)
    jal  ra, test_traduccion_c

    # -------------------------------------------------------------------------
    # FIN DEL PROGRAMA (Syscall Exit)
    # -------------------------------------------------------------------------
    li   a7, 10
    ecall


# ===============================================================================
# IMPLEMENTACIÓN DE PRUEBAS Y MÓDULOS
# ===============================================================================

# -------------------------------------------------------------------------------
# 1. TEST CIFRADO FEISTEL DE 4 RONDAS
# -------------------------------------------------------------------------------
test_feistel:
    addi sp, sp, -4
    sw   ra, 0(sp)

    la   a0, tabla_feistel
    lw   a2, palabra_feistel
    jal  ra, cifrado_feistel

    la   t0, res_feistel
    sw   a2, 0(t0)             # Guardar resultado en memoria

    lw   ra, 0(sp)
    addi sp, sp, 4
    ret

cifrado_feistel:
    addi sp, sp, -12
    sw   ra, 0(sp)
    sw   s0, 4(sp)
    sw   s1, 8(sp)

    srli t0, a2, 16            # t0 = L0 (bits 31-16)

    # CORRECCIÓN DE RANGO INMEDIATO:
    # Se extraen los 16 bits inferiores (R0) mediante slli/srli para evitar sobrepasar los 12 bits de 'andi'
    slli t1, a2, 16
    srli t1, t1, 16            # t1 = R0 (bits 15-0)

    li   s0, 0                 # Contador de rondas (0..3)
    li   s1, 4                 # Total de rondas = 4

feistel_loop:
    beq  s0, s1, feistel_fin

    mv   t2, t0                # t2 = L_{n-1}
    mv   t0, t1                # Ln = R_{n-1}

    li   t3, 0                 # t3 = Resultado F
    li   t4, 0                 # z = 0..15 (índice bit destino)

f_perm_loop:
    li   t5, 16
    beq  t4, t5, f_perm_fin

    add  t5, a0, t4            # Direccion T[z]
    lbu  t6, 0(t5)             # t6 = Bit original a tomar

    srl  a3, t1, t6            # Extraer bit
    andi a3, a3, 1

    sll  a3, a3, t4            # Colocar en posicion z
    or   t3, t3, a3            # Acumular en F

    addi t4, t4, 1
    j    f_perm_loop

f_perm_fin:
    xor  t1, t2, t3            # Rn = L_{n-1} XOR F(R_{n-1})
    addi s0, s0, 1
    j    feistel_loop

feistel_fin:
    slli t0, t0, 16
    or   a2, t0, t1            # a2 = (L4 << 16) | R4

    lw   ra, 0(sp)
    lw   s0, 4(sp)
    lw   s1, 8(sp)
    addi sp, sp, 12
    ret


# -------------------------------------------------------------------------------
# 2. TEST DECODIFICADOR DE CAMPOS DE BITS
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
    andi t4, t3, 0x3FF         # Op1 = bits 9-0 (10 bits)
    srli t5, t3, 10
    andi t5, t5, 0xF           # OpCode = bits 13-10 (4 bits)
    srli t6, t3, 14
    andi t6, t6, 0x1F          # Op2 = bits 18-14 (5 bits)
    srli a1, t3, 19
    andi a1, a1, 0x7FF         # Op3 = bits 29-19 (11 bits)

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

    j    op_case_default       # OpCodes 8 a 15

op_case_0_4: # (Op1 XOR Op2) AND Op3
    xor  a0, t4, t6
    and  a0, a0, a1
    j    decod_fin

op_case_1_5: # Op1 - Op2 - Op3
    sub  a0, t4, t6
    sub  a0, a0, a1
    j    decod_fin

op_case_2_6: # (Op1 >> Op2) << Op3
    srl  a0, t4, t6
    sll  a0, a0, a1
    j    decod_fin

op_case_3_7: # Op3 AND Op2
    and  a0, a1, t6
    j    decod_fin

op_case_default: # Op1 + Op2 + Op3
    add  a0, t4, t6
    add  a0, a0, a1

decod_fin:
    sw   a0, 0(t2)
    ret


# -------------------------------------------------------------------------------
# 3. TEST BUBBLE SORT DESCENDENTE
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
    addi s0, a2, -1             # N - 1
    li   t0, 0                  # i = 0

outer_loop:
    beq  t0, s0, sort_fin
    li   t1, 0                  # j = 0
    sub  t2, s0, t0              # limite j = (N - 1) - i

inner_loop:
    beq  t1, t2, next_outer
    slli t3, t1, 2
    add  t3, a1, t3              # &a1[j]
    lw   s1, 0(t3)              # A = a1[j]
    lw   a3, 4(t3)              # B = a1[j+1]

    bge  s1, a3, no_swap
    sw   a3, 0(t3)
    sw   s1, 4(t3)

no_swap:
    addi t1, t1, 1              # j++
    j    inner_loop

next_outer:
    addi t0, t0, 1              # i++
    j    outer_loop

sort_fin:
    lw   ra, 0(sp)
    lw   s0, 4(sp)
    lw   s1, 8(sp)
    addi sp, sp, 12
    ret


# -------------------------------------------------------------------------------
# 4. TEST CONTEO ASCII Y TOP 2 FRECUENCIAS
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
    addi sp, sp, -108           # Reservar 104 bytes para contadores + 4 bytes para ra
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

    li   t2, 97                 # 'a'
    li   t3, 122                # 'z'
    blt  t1, t2, check_mayus
    bgt  t1, t3, check_mayus
    addi t1, t1, -32

check_mayus:
    li   t2, 65                 # 'A'
    li   t3, 90                 # 'Z'
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
    li   a0, -1                 # Max 1 Frecuencia
    li   a1, -1                 # Max 2 Frecuencia
    li   s4, 65                 # ASCII Max 1
    li   s5, 65                 # ASCII Max 2
    li   t0, 0                  # Indice 0..25

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
# 5. TEST ARITMÉTICA SOFT (MULTIPLICACIÓN Y DIVISIÓN)
# -------------------------------------------------------------------------------
test_aritmetica_soft:
    addi sp, sp, -4
    sw   ra, 0(sp)

    # Multiplicacion: 12 * 9
    li   a0, 12
    li   a1, 9
    jal  ra, multiplicar_soft
    la   t0, res_mult
    sw   a0, 0(t0)

    # Division: 108 / 10
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
    li   t0, 0                  # Cociente
div_loop:
    blt  a0, a1, div_fin
    sub  a0, a0, a1
    addi t0, t0, 1
    j    div_loop
div_fin:
    mv   a1, a0                 # Residuo en a1
    mv   a0, t0                 # Cociente en a0
    ret


# -------------------------------------------------------------------------------
# 6. TEST TRADUCCIÓN DE C (ANEXO C)
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