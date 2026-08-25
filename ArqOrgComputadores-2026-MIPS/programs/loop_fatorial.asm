# loop_fatorial.asm
# Calcula 5! (fatorial de 5) usando um laço controlado por beq/j.
# Resultado final fica em $s0.

        addi $t0, $zero, 5    # $t0 = n = 5
        addi $s0, $zero, 1    # $s0 = resultado (acumulador), começa em 1
        addi $t1, $zero, 0    # $t1 = valor de comparação (zero)

loop:
        beq  $t0, $t1, fim    # se n == 0, encerra o laço

        # resultado = resultado * n  -> como não há "mul" no subset,
        # soma "resultado" repetidamente "n" vezes usando um loop interno
        addi $t2, $zero, 0    # $t2 = acumulador da multiplicação
        addi $t3, $zero, 0    # $t3 = contador do loop interno

mult_loop:
        beq  $t3, $t0, mult_fim
        add  $t2, $t2, $s0
        addi $t3, $t3, 1
        j    mult_loop

mult_fim:
        add  $s0, $t2, $zero  # resultado = acumulador da multiplicação
        addi $t0, $t0, -1     # n--
        j    loop

fim:
        sw   $s0, 0($zero)    # guarda o resultado final na memória[0]
