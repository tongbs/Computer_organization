.data

.text
.global main

main:
	li $v0,5
	syscall
	move $t0,$v0 #$t0 = a(x)
	
	li $v0,5
	syscall
	move $t1,$v0 #$t1 = b(y)
	
	li $v0,5
	syscall
	move $t2,$v0 #$t2 = m(n)
	
	move $s3,$zero
	addi $s3,$s3,1 #$s3 = 1
	move $s4,$zero
	addi $s4,$s4,2 #s4 = 2
	
	move $s2,$zero
	
	jal mod_op
	move $t1,$v0
	move $a0,$t1
	li $v0,1
	syscall
	li $v0,10
	syscall
	
mod_op:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	beqz $t1,exit1
	div $t1,$s4  
	mfhi $t4  #$t4 = y%2
	mflo $t5  #t5 = y/2
	beq $t4,$zero,else
	div $t0,$t2
	mfhi $t6  #$t6 = x%n
	move $t1,$t5
	jal mod_op
	lw $ra,0($sp)
	addi $sp,$sp,4
	mul $t1,$v0,$t6
	mul $t1,$t1,$v0
	div $t1,$t2
	mfhi $t7
	move $v0,$t7
	jr $ra

else:
	div $t1,$s4  
	mfhi $t4  #$t4 = y%2
	mflo $t5  #t5 = y/2
	move $t1,$t5
	jal mod_op
	lw $ra,0($sp)
	addi $sp,$sp,4
	mul $t1,$v0,$v0
	div $t1,$t2
	mfhi $s2
	move $v0,$s2
	jr $ra
exit1:
	move $v0,$s3
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra