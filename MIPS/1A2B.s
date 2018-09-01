.data
msg1:	.asciiz "Input:\n"
a_num:  .space 16
b_num:	.space 16
msg2:	.asciiz "ERROR!\n"
msg3:	.asciiz "ERROR!\n"
msg4:	.asciiz "Output:\n"
msg5:	.asciiz "A"
msg6:	.asciiz "B"


.text
.global main

main:
	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0    #a = $t0
	
	move $s1,$zero
	addi $s1,$s1,10
	move $t1,$zero  #i = 0
	la $s0,a_num  #--------------

for1:
	slti $t2,$t1,4
	beq $t2,$zero,ifa
	sll $t3,$t1,2
	add $t4,$t3,$s0
	div $t0,$s1
	mfhi $t5  #a%10
	mflo $t6  #a/10
	sw $t5,0($t4)
	move $t0,$t6
	addi $t1,$t1,1
	j for1

ifa:
	lw $t0,0($s0)
	#move $a0,$t0
	#li $v0,1
	#syscall
	
	lw $t1,4($s0)
	#move $a0,$t1
	#li $v0,1
	#syscall
	
	lw $t2,8($s0)
	#move $a0,$t2
	#li $v0,1
	#syscall
	
	lw $t3,12($s0)
	#move $a0,$t3
	#li $v0,1
	#syscall
	
	#li $v0,10
	#syscall
	
	beq $t0,$t1,exita
	beq $t0,$t2,exita
	beq $t0,$t3,exita
	beq $t1,$t2,exita
	beq $t1,$t3,exita
	beq $t2,$t3,exita
	
	li $v0,5
	syscall
	move $t0,$v0   #$t0 = b
	move $s1,$zero
	addi $s1,$s1,10 #$s1 = 10
	move $t1,$zero  #i = 0
	la $s2,b_num   #---------------
for2:
	slti $t2,$t1,4
	beq $t2,$zero,ifb
	sll $t3,$t1,2
	add $t4,$t3,$s2
	div $t0,$s1
	mfhi $t5  #b%10
	mflo $t6  #b/10
	sw $t5,0($t4)
	move $t0,$t6
	addi $t1,$t1,1
	j for2

ifb:
	lw $t0,0($s2)
	
	lw $t1,4($s2)
	
	lw $t2,8($s2)

	lw $t3,12($s2)
	
	beq $t0,$t1,exitb
	beq $t0,$t2,exitb
	beq $t0,$t3,exitb
	beq $t1,$t2,exitb
	beq $t1,$t3,exitb
	beq $t2,$t3,exitb
	
	move $s1,$zero #i = 0
	move $s3,$zero #$s3 = A
	move $s4,$zero #$s4 = B 
fori:
	slti $t0,$s1,4
	beq $t0,$zero,output
	sll $t1,$s1,2
	add $t2,$t1,$s0 #a_num address
	add $t3,$t1,$s2 #b_num address
	lw $t4,0($t2)
	lw $t5,0($t3)
	move $s5,$zero  #j = 0
	bne $t4,$t5,forj
	addi $s3,$s3,1
forj:
	slti $t0,$s5,4
	beq $t0,$zero,foriplus
	#move $s7,$zero #flag1
	#move $s6,$zero #flag2
	sll $t1,$s5,2
	sll $t2,$s1,2
	add $t3,$t2,$s0
	add $t4,$t1,$s2
	lw $t5,0($t3)
	lw $t6,0($t4)
	bne $t5,$t6,Else
	beq $s1,$s5,Else
	addi $s4,$s4,1
	
	addi $s5,$s5,1
	j forj
	
Else:
	addi $s5,$s5,1
	j forj

foriplus:
	addi $s1,$s1,1
	j fori
	
output:
	li $v0,4
	la $a0,msg4
	syscall
	move $a0,$s3
	li $v0,1
	syscall
	li $v0,4
	la $a0,msg5
	syscall
	move $a0,$s4
	li $v0,1
	syscall
	li $v0,4
	la $a0,msg6
	syscall
	li $v0,10
	syscall
		
exita:
	li $v0,4
	la $a0,msg2
	syscall
	li $v0,10
	syscall
exitb:
	li $v0,4
	la $a0,msg3
	syscall
	li $v0,10
	syscall
	

	
