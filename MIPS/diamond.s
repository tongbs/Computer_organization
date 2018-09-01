.data
msg1:	.asciiz " "
msg2:	.asciiz "*"
msg3:	.asciiz "\n"



.text
.global main

main:
	li $v0,5
	syscall
	move $s0,$v0  #put n in $s0
	addi $s1,$s0,-1 #put n-1 in $s1
#forloop
	move $t0,$zero
	move $t5,$zero
	addi $t0,$t0,1 #i = 1
fori1:
	slt $t1,$s0,$t0
	bne $t1,$zero,fori2
	move $t2,$zero
	addi $t2,$t2,1 #j = 1
	sub $t3,$s0,$t0 #$t3 = n-i
	addi $t5,$t3,1 #j = n-i+1
	add $t4,$s0,$t0 #$t4 = n+i
forj1:
	slt $t1,$t3,$t2
	bne $t1,$zero,forjj1
	li $v0,4
	la $a0,msg1
	syscall
	addi $t2,$t2,1  #j++
	j forj1
	
forjj1:
	slt $t1,$t5,$t4
	beq $t1,$zero,fori1plus
	li $v0,4
	la $a0,msg2
	syscall
	addi $t5,$t5,1 #j++
	j forjj1

fori1plus:
	li $v0,4
	la $a0,msg3
	syscall
	addi $t0,$t0,1
	j fori1
	
fori2:
	slti $t1,$s1,1
	bne $t1,$zero,exit
	move $t2,$zero
	addi $t2,$t2,1 #j=1
	sub $t3,$s0,$s1  #$t3 = n-i
	addi $t5,$t3,1 #j = n-i+1
	add $t4,$s0,$s1 #$t4 = n+i
	
forj2:
	slt $t1,$t3,$t2
	bne $t1,$zero,forjj2
	li $v0,4
	la $a0,msg1
	syscall
	addi $t2,$t2,1 #j++
	j forj2

forjj2:
	slt $t1,$t5,$t4
	beq $t1,$zero,fori2plus
	li $v0,4
	la $a0,msg2
	syscall
	addi $t5,$t5,1
	j forjj2

fori2plus:
	li $v0,4
	la $a0,msg3
	syscall
	addi $s1,$s1,-1
	j fori2
	
exit:
	li $v0,10
	syscall
