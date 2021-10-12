 .text

.globl main

main:
    # input of the range number
    li $v0, 4
    la $a0, prompt
    syscall

    # take n
    li $v0, 5
    syscall
    move $t2, $v0
    
    li $t1, 2
    
   
    # for loop for printing primes
    loop:       
        # put num in $a0
        #checkPrime called with jal 
        move $a0, $t1
        jal checkPrime
        #if $v0 is yes print else dont
        move $t8, $v0
        beq $t8, $zero, continue

        li $v0, 1
        move $a0, $t1
        syscall

        li $v0, 4
        la $a0, comma
        syscall

    continue:
       
        addi $t1, $t1, 1
        bgt $t1, $t2, end_loop
        j loop
    end_loop:
exit:
    li $v0, 10  
    syscall 

# function for checking a number prime
# a0 gets number, v0 gets the return yes/no
# without stack

checkPrime:
    li $t0, 2
    # loop
  
    loopCheck:
        rem $t3, $a0, $t0
        beq $t3, $zero, not_prime
        addi $t0, $t0, 1
        beq $t0, $a0, end_loop_yes
        j loopCheck

    # put 1/0 in $v0 as prime/not prime resp.
    not_prime:
        li $v0, 0
        jr $ra
    end_loop_yes:
        li $v0, 1
        jr $ra


.data

prompt: .asciiz "Enter range number: "
comma: .asciiz " "
endline: .asciiz "\n"
