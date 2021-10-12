.data 
    array: .word -8 , 6, -107, -210, 1, 68, 90, 43, 1, 14   
    min: .asciiz " is the minimum number."

.text
.globl main

main:
    addi $s1, $zero, 10  # s1 = 10
    addi $s0, $zero, 1   # s0 = 1 , its the loop variable
    la $t1, array        # pointer to first element  ptr1
    addi $t2, $t1, 4     # pointer to second element ptr2

    loop:
        beq $s0, $s1, endloop    # if i==10, break loop
        jal swap  
        addi $s0, $s0, 1         # i++
        addi $t1, $t1, 4         # ptr1++
        addi $t2, $t2, 4         # ptr2++ 
        lw $t5, 0($t1)            
        move $a0, $t5            # storing min in $a0
        j loop 
    endloop:
        li $v0, 1
        syscall
        li $v0, 4
        la $a0, min 
        syscall

    li $v0, 10
    syscall
swap:                          # swaps values at ptr1 and ptr2 if *ptr1 < *ptr2
    lw $t3, 0($t1)
    lw $t4, 0($t2)
    bgt $t3, $t4, endswap
    sw $t3, 0($t2)
    sw $t4, 0($t1)
    endswap:
    jr $ra
