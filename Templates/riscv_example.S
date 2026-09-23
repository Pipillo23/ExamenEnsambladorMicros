.text
.option nopic
.globl _start

_start:
    # Suma de dos constantes y termina el programa
    li t0, 5
    li t1, 7
    add a0, t0, t1

    # syscall exit(0) en Linux RISC-V
    li a7, 93
    ecall

    # Si por alguna razón ecall falla, dejamos un bucle seguro
1:
    j 1b
