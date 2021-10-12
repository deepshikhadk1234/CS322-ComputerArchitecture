.data

array: .space 40

prompt: .asciiz "Enter 10 numbers:\n";
msg: .asciiz "Array after bubble sort:"
end: .asciiz "\n";

.text

.globl main
j main

swapfunc:
	lw $t5, 0($a0)
	lw $t6, 0($a1)
	sw $t6, 0($a0)
	sw $t5, 0($a1)
	jr $ra 	

main:
	# taking inputs in the array
	takeinput:
		li $v0,4
		la $a0, prompt
		syscall
		
		la $t1, array
		addi $t0,$t1,0		# $t0 is iterator
		addi $t2,$t1,40		# $t2 is end
		inploop:
			beq $t0,$t2, doneinput
			li $v0,5
			syscall
			sw $v0,0($t0)
			addi $t0,$t0,4
			j inploop
	doneinput:

	
	bubblesort:
		la $t0, array		# iterator
		la $t2, 40($t0)		# end pointer
		li $t7, 0		# flag to check swap happened or not during the pass
		pass:
			addi $t1,$t0,4	# adjacent element to be compared	
			bge $t0,$t2, donepass
			lw $t5, 0($t0)
	 		lw $t6, 0($t1)
			ble $t5,$t6, continue
				#swap subroutine
				addi $a0,$t0,0	
				addi $a1,$t1,0
				li $t7,1
				jal swapfunc
			continue:
			addi $t0,4
			j pass
		donepass:
		
		beq $t7,$zero, donesort
		j bubblesort
	donesort:

	
	# outputting the new array
	displayoutput:
		li $v0,4
		la $a0, msg
		syscall
		
		la $t1, array
		addi $t0,$t1,0		# $t0 is iterator
		addi $t2,$t1,40		# $t2 is end
		
		outputloop:
			beq $t0,$t2, doneoutput
		
			li $v0, 4
			la $a0, end
			syscall
			
			li $v0, 1
			lw $a0, 0($t0)
			syscall
			
			addi $t0,$t0,4
			j outputloop
	doneoutput:
	
	
	
	exit:
		li $v0, 10
		syscall
