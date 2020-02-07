# Array Searching Algorithm assembly program 
.data
A: .space 40
msg: .asciiz "Please enter 10 integers to the array \n"
msg2: .asciiz "Array elements inserted.\nEnter an element to search: \n"
msg3: .asciiz "\nValue not found or does not exist"
msg4: .asciiz "\nThe element "
msg5: .asciiz " is found in position "
msg6: .asciiz "\nThe searches element has been found "
msg7: .asciiz " times"
msg8:.asciiz "\nThe binary conversion of the searched number: \n"
.text

#print msg
li $v0,4
la $a0,msg
syscall
#read array 10 values 
la $s0,A
li $t1,1
li $t2,10
loop1: bgt $t1,$t2,exit1
li $v0,5
syscall
sw $v0,0($s0)
addi $s0,$s0,4
addi $t1,$t1,1
j loop1
exit1:
#prnt msg2
li $v0,4
la $a0,msg2
syscall
#element to search
li $v0,5
syscall
move $t3,$v0
#search
la $s0,A
li $t1,1
li $t2,10
li $t4,0	#count
loop2: bgt $t1,$t2,exit2
lw $t5,0($s0)	#load the element
bne $t5,$t3,skip	# if found  print the value $t3 is found in position $t1 +count 
li $v0,4	# "the value"
la $a0,msg4
syscall
li $v0,1	# $t3
move $a0,$t3
syscall
li $v0,4	# "is found in position"
la $a0,msg5
syscall
li $v0,1	# $t1
move $a0,$t1
syscall
addi $t4,$t4,1	#count
skip:
addi $s0,$s0,4
addi $t1,$t1,1
j loop2
exit2:
beq $t4,$zero,notfound
li $v0,4	# "the searched element has been found"
la $a0,msg6
syscall
li $v0,1	# count
move $a0,$t4
syscall
li $v0,4	# "times"
la $a0,msg7
syscall
j exit
notfound:
li $v0,4	#print value doesnt exist in the array
la $a0,msg3
syscall	
exit:
#msg to show binary
li $v0,4
la $a0,msg8
syscall
#go to procedure
move $a3,$t3
jal printbi

#exit
li $v0,10
syscall

printbi:
#initialize
move $s1, $zero  
li $s3, 1
sll $s3, $s3, 31
addi $s4, $zero, 32	# loop counter
loop:
and $s1, $a3, $s3
beq $s1, $zero, print	#if $s1 zero, go to print
add $s1, $zero, $zero
addi $s1, $zero, 1
j print
#print the number
print:	
li $v0, 1
move $a0, $s1
syscall
srl $s3, $s3, 1
addi $s4, $s4, -1
bne $s4, $zero, loop
jr $ra
