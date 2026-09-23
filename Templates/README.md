# Programa ejemplo en RISC-V

Se ha creado un ejemplo simple en ensamblador RISC-V en [riscv_example.S](riscv_example.S).

## Qué hace
- Carga dos valores en `t0` y `t1`
- Suma ambos con `add`
- Lo guarda en `a0`
- Llama a `exit` con `ecall`

## Formatos de instrucción en RISC-V

### R-type
Usado para operaciones entre registros, por ejemplo:
- `add rd, rs1, rs2`
- `sub rd, rs1, rs2`
- `and rd, rs1, rs2`

Formato general:
- `opcode` + `rd` + `funct3` + `rs1` + `rs2` + `funct7`

### I-type
Usado para inmediatos y cargas:
- `addi rd, rs1, imm`
- `lw rd, imm(rs1)`
- `jalr rd, rs1, imm`

Formato general:
- `opcode` + `rd` + `funct3` + `rs1` + `imm[11:0]`

### S-type
Usado para almacenar en memoria:
- `sw rs2, imm(rs1)`
- `sb rs2, imm(rs1)`

Formato general:
- `opcode` + `imm[4:0]` + `rs1` + `rs2` + `funct3` + `imm[11:5]`

### B-type
Usado para saltos condicionales:
- `beq rs1, rs2, label`
- `bne rs1, rs2, label`

Formato general:
- `opcode` + `imm[12]` + `imm[10:5]` + `rs2` + `rs1` + `funct3` + `imm[4:1]` + `imm[11]`

### U-type
Usado para cargar direcciones grandes:
- `lui rd, imm`
- `auipc rd, imm`

Formato general:
- `opcode` + `rd` + `imm[31:12]`

### J-type
Usado para saltos incondicionales:
- `jal rd, label`

Formato general:
- `opcode` + `rd` + `imm[20|10:1|11|19:12]`

## Comandos útiles

Si tienes un compilador RISC-V instalado:

```bash
riscv64-unknown-linux-gnu-gcc -nostdlib -static -o riscv_example riscv_example.S
```

O para un entorno bare-metal:

```bash
riscv64-unknown-elf-gcc -nostdlib -Ttext 0x1000 -o riscv_example riscv_example.S
```

## Nota
Este ejemplo está pensado para Linux con syscall `exit`, y sirve como base para estudiar el formato y la sintaxis de RISC-V.
