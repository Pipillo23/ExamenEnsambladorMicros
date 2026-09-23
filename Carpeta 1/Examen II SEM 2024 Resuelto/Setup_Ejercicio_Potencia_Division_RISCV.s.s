
.data
.text

li t0, 0 # registro para almacenar el resultado de las funciones
li t1, 7 # registro para el argumento a de los parámetros de las funciones
li t2, 9 # registro para el argumento b de los parámetros de las funciones
li s0, 0 # conteo sumatoria
li s1, 0 # valor sumatoria

main:
jal ra, comparacion

mv t2, t0
li t1, 11

jal ra, comparacion

li t1, 5
jal ra, sumatoria

jal x0, fin

comparacion:
bge t1, t2, resultado_comparacion # compara si el registro t2
mv t0, t2

ret

resultado_comparacion:
mv t0, t1

ret

sumatoria:
blt t1, s0, terminar_sumatoria

add s1, s1, s0
addi s0, s0, 1

j sumatoria

terminar_sumatoria:
li s0, 0
mv t0, s1

li s1, 0

ret

fin:
jal x0, fin