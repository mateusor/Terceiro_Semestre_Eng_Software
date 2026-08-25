# soma_vetores.asm
# Soma dois "vetores" de 4 posições guardados na memória de dados
# e escreve o resultado em um terceiro vetor.
#
# vetor A: endereços 0, 4, 8, 12
# vetor B: endereços 16, 20, 24, 28
# vetor C (resultado): endereços 32, 36, 40, 44

        addi $t0, $zero, 0      # $t0 = 0  -> contador de posições (0..3)
        addi $t1, $zero, 4      # $t1 = 4  -> limite do loop

        # inicializa vetor A com valores 10, 20, 30, 40
        addi $t2, $zero, 10
        sw   $t2, 0($zero)
        addi $t2, $zero, 20
        sw   $t2, 4($zero)
        addi $t2, $zero, 30
        sw   $t2, 8($zero)
        addi $t2, $zero, 40
        sw   $t2, 12($zero)

        # inicializa vetor B com valores 1, 2, 3, 4
        addi $t2, $zero, 1
        sw   $t2, 16($zero)
        addi $t2, $zero, 2
        sw   $t2, 20($zero)
        addi $t2, $zero, 3
        sw   $t2, 24($zero)
        addi $t2, $zero, 4
        sw   $t2, 28($zero)

        addi $t0, $zero, 0      # reinicia contador

loop:
        beq  $t0, $t1, fim       # se contador == 4, encerra

        sll  $t3, $t0, 2         # $t3 = contador * 4 (offset em bytes)

        addi $t4, $t3, 0         # $t4 = offset de A (base 0)
        lw   $t5, 0($t4)         # $t5 = A[i]

        addi $t6, $t3, 16        # $t6 = offset de B (base 16)
        lw   $t7, 0($t6)         # $t7 = B[i]

        add  $t8, $t5, $t7       # $t8 = A[i] + B[i]

        addi $t9, $t3, 32        # $t9 = offset de C (base 32)
        sw   $t8, 0($t9)         # C[i] = A[i] + B[i]

        addi $t0, $t0, 1         # contador++
        j    loop

fim:
        addi $s0, $zero, 1       # marcador: programa concluído
