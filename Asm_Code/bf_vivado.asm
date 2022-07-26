# str: 0x10010000
# pattern: 0x10010200

# load the str and the pattern
li $a1 0x00000000   # $a1: second argument:str
li $a3 0x00000200   # $a3: fourth argument:pattern

# find the length of the str and the pattern
# a0 : length of the str
# a2 : length of the pattern
add $a0 $0 $0
move $t0 $a1    # $t0: pointer
For_begin_str:
lw $t1 0($t0)   # $t1: element
beq $t1 $0 For_end_str
addi $a0 $a0 1
addi $t0 $t0 4
j For_begin_str
For_end_str:

add $a2 $0 $0
move $t0 $a3
For_begin_pattern:
lw $t1 0($t0)   # $t1: element
beq $t1 $0 For_end_pattern
addi $a2 $a2 1
addi $t0 $t0 4
j For_begin_pattern
For_end_pattern:

sll $a0 $a0 2
sll $a2 $a2 2

jal brute_force

# Display the unmber
# Decode
# t0:
andi $a0 $v0 0x0000000f
jal Decode
move $t0 $v1
ori $t0 $t0 0x00000e00
# t1:
andi $a0 $v0 0x000000f0
srl $a0 $a0 4
jal Decode
move $t1 $v1 
ori $t1 $t1 0x00000d00
# t2
andi $a0 $v0 0x00000f00
srl $a0 $a0 8
jal Decode
move $t2 $v1
ori $t2 $t2 0x00000b00
# t3 
andi $a0 $v0 0x0000f000
srl $a0 $a0 12
jal Decode
move $t3 $v1
ori $t3 $t3 0x00000300

li $a0 0x40000010
Display_t0:
sw $t0 0($a0)
jal count
sw $t1 0($a0)
jal count
sw $t2 0($a0)
jal count
sw $t3 0($a0)
jal count
j Display_t0

count:
li $s0 0
li $s1 12500
add_one:
addi $s0 $s0 1
bne $s0 $s1 add_one
jr $ra

brute_force:
# # # # #  your code here # # # # # 
li $t0 0
li $t1 0
li $v0 0            # $v0: cnt
bigger_for_judge:
sub $t2 $a0 $a2
blt $t2 $t0 bigger_for_exit
li $t1 0
smaller_for_judge:
slt $t2 $t1 $a2     
beq $t2 $zero smaller_for_exit
add $t2 $t0 $t1     # i + j
add $t2 $t2 $a1     # adddress of str[i + j]
lw $t2 0($t2)
add $t3 $a3 $t1     # address of pattern[j]
lw $t3 0($t3)
bne $t2 $t3 smaller_for_exit
addi $t1 $t1 4
j smaller_for_judge
smaller_for_exit:
bne $t1 $a2 no_need_to_add_one
addi $v0 $v0 1
no_need_to_add_one:
addi $t0 $t0 4
j bigger_for_judge
bigger_for_exit:
jr $ra

Decode:
# a0 16������
beq $a0 0 zero
beq $a0 1 one
beq $a0 2 two
beq $a0 3 three
beq $a0 4 four
beq $a0 5 five
beq $a0 6 six
beq $a0 7 seven
beq $a0 8 eight
beq $a0 9 nine
beq $a0 10 aa
beq $a0 11 bb
beq $a0 12 cc
beq $a0 13 dd
beq $a0 14 ee
beq $a0 15 ff
li $v1 0xff
j ok
zero: 
li $v1 0xc0
j ok
one:
li $v1 0xf9
j ok
two:
li $v1 0xa4
j ok
three:
li $v1 0xb0
j ok
four:
li $v1 0x99
j ok
five:
li $v1 0x92
j ok
six:
li $v1 0x82
j ok
seven:
li $v1 0xf8
j ok
eight:
li $v1 0x80
j ok
nine:
li $v1 0x90
j ok
aa:
li $v1 0x88
j ok
bb:
li $v1 0x83
j ok
cc:
li $v1 0xc6
j ok
dd:
li $v1 0xa1
j ok
ee:
li $v1 0x84
j ok
ff:
li $v1 0x8e
j ok
ok:
jr $ra
