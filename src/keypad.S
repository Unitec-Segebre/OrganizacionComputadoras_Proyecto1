#include "system.h"

	.data
key_1_last_used_at: .word 0x00000000
key_2_last_used_at: .word 0x00000000
key_3_last_used_at: .word 0x00000000
key_4_last_used_at: .word 0x00000000
key_5_last_used_at: .word 0x00000000
key_6_last_used_at: .word 0x00000000
key_7_last_used_at: .word 0x00000000
key_8_last_used_at: .word 0x00000000
frame_last_used_at: .word 0x00000000

	.text
	.global delay_ms
	.global keypad_init
	.global keypad_getkey
	.global framespersecond
	.global ballspeed

delay_ms:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	#start
	lui $t0, %hi(MS_COUNTER_REG_ADDR)
	lw $t1, %lo(MS_COUNTER_REG_ADDR)($t0)	#start_time
delay_ms_while:
	lw $t2, %lo(MS_COUNTER_REG_ADDR)($t0)	#timer
	sub $t2, $t2, $t1
	slt $t2, $t2, $a0
	bnez $t2, delay_ms_while
	#end
	addi $sp, $sp, 4
	lw $ra, -4($sp)
	jr $ra

keypad_init:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	#start
	# la $t0, key_last_used_at
	# sw $zero, 0($t0)
	lui $t0, %hi(key_1_last_used_at)
	sw $zero, %lo(key_1_last_used_at)($t0)
	lui $t0, %hi(key_2_last_used_at)
	sw $zero, %lo(key_2_last_used_at)($t0)
	lui $t0, %hi(key_3_last_used_at)
	sw $zero, %lo(key_3_last_used_at)($t0)
	lui $t0, %hi(key_4_last_used_at)
	sw $zero, %lo(key_4_last_used_at)($t0)
	lui $t0, %hi(key_5_last_used_at)
	sw $zero, %lo(key_5_last_used_at)($t0)
	lui $t0, %hi(key_6_last_used_at)
	sw $zero, %lo(key_6_last_used_at)($t0)
	lui $t0, %hi(key_7_last_used_at)
	sw $zero, %lo(key_7_last_used_at)($t0)
	lui $t0, %hi(key_8_last_used_at)
	sw $zero, %lo(key_8_last_used_at)($t0)
	#end
	addi $sp, $sp, 4
	lw $ra, -4($sp)
	jr $ra

keypad_getkey:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	#start
	move $v0, $zero
	lui $t0, %hi(MS_COUNTER_REG_ADDR)
	lw $t0, %lo(MS_COUNTER_REG_ADDR)($t0)	#timer
	lui $t1, %hi(KEYPAD_STATE_REG_ADDR)
	lb $t1, %lo(KEYPAD_STATE_REG_ADDR)($t1)	#keys pressed
	li $t2, 50
	li $t3, 1
	and $t4, $t3, $t1
	bne $t4, $t3, keypad_getkey_check_key_2
	lui $t5, %hi(key_1_last_used_at)
	lw $t4, %lo(key_1_last_used_at)($t5)	#key 1 last used at
	sub $t4, $t0, $t4
	slt $t4, $t4, $t2
	bnez $t4, keypad_getkey_check_key_2
	li $v0, 1
	sw $t0, %lo(key_1_last_used_at)($t5)
	j keypad_getkey_end
keypad_getkey_check_key_2:
	sll $t3, $t3, 1
	and $t4, $t3, $t1
	bne $t4, $t3, keypad_getkey_check_key_3
	lui $t5, %hi(key_2_last_used_at)
	lw $t4, %lo(key_2_last_used_at)($t5)	#key 2 last used at
	sub $t4, $t0, $t4
	slt $t4, $t4, $t2
	bnez $t4, keypad_getkey_check_key_3
	li $v0, 2
	sw $t0, %lo(key_2_last_used_at)($t5)
	j keypad_getkey_end
keypad_getkey_check_key_3:
	sll $t3, $t3, 1
	and $t4, $t3, $t1
	bne $t4, $t3, keypad_getkey_check_key_4
	lui $t5, %hi(key_3_last_used_at)
	lw $t4, %lo(key_3_last_used_at)($t5)	#key 3 last used at
	sub $t4, $t0, $t4
	slt $t4, $t4, $t2
	bnez $t4, keypad_getkey_check_key_4
	li $v0, 3
	sw $t0, %lo(key_3_last_used_at)($t5)
	j keypad_getkey_end
keypad_getkey_check_key_4:
	sll $t3, $t3, 1
	and $t4, $t3, $t1
	bne $t4, $t3, keypad_getkey_check_key_5
	lui $t5, %hi(key_4_last_used_at)
	lw $t4, %lo(key_4_last_used_at)($t5)	#key 4 last used at
	sub $t4, $t0, $t4
	slt $t4, $t4, $t2
	bnez $t4, keypad_getkey_check_key_5
	li $v0, 4
	sw $t0, %lo(key_4_last_used_at)($t5)
	j keypad_getkey_end
keypad_getkey_check_key_5:
	sll $t3, $t3, 1
	and $t4, $t3, $t1
	bne $t4, $t3, keypad_getkey_check_key_6
	lui $t5, %hi(key_5_last_used_at)
	lw $t4, %lo(key_5_last_used_at)($t5)	#key 5 last used at
	sub $t4, $t0, $t4
	slt $t4, $t4, $t2
	bnez $t4, keypad_getkey_check_key_6
	li $v0, 5
	sw $t0, %lo(key_5_last_used_at)($t5)
	j keypad_getkey_end
keypad_getkey_check_key_6:
	sll $t3, $t3, 1
	and $t4, $t3, $t1
	bne $t4, $t3, keypad_getkey_check_key_7
	lui $t5, %hi(key_6_last_used_at)
	lw $t4, %lo(key_6_last_used_at)($t5)	#key 6 last used at
	sub $t4, $t0, $t4
	slt $t4, $t4, $t2
	bnez $t4, keypad_getkey_check_key_7
	li $v0, 6
	sw $t0, %lo(key_6_last_used_at)($t5)
	j keypad_getkey_end
keypad_getkey_check_key_7:
	sll $t3, $t3, 1
	and $t4, $t3, $t1
	bne $t4, $t3, keypad_getkey_check_key_8
	lui $t5, %hi(key_7_last_used_at)
	lw $t4, %lo(key_7_last_used_at)($t5)	#key 7 last used at
	sub $t4, $t0, $t4
	slt $t4, $t4, $t2
	bnez $t4, keypad_getkey_check_key_8
	li $v0, 7
	sw $t0, %lo(key_7_last_used_at)($t5)
	j keypad_getkey_end
keypad_getkey_check_key_8:
	sll $t3, $t3, 1
	and $t4, $t3, $t1
	bne $t4, $t3, keypad_getkey_end
	lui $t5, %hi(key_8_last_used_at)
	lw $t4, %lo(key_8_last_used_at)($t5)	#key 8 last used at
	sub $t4, $t0, $t4
	slt $t4, $t4, $t2
	bnez $t4, keypad_getkey_end
	li $v0, 8
	sw $t0, %lo(key_8_last_used_at)($t5)
keypad_getkey_end:
	#end
	addi $sp, $sp, 4
	lw $ra, -4($sp)
	jr $ra

framespersecond:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	#start
	lui $t0, %hi(MS_COUNTER_REG_ADDR)
	lui $t1, %hi(frame_last_used_at)
	lw $t1, %lo(frame_last_used_at)($t1)
	ori $t2, $zero, 1000
	divu $t2, $a0
	mflo $t4
framespersecond_while:
	lw $t2, %lo(MS_COUNTER_REG_ADDR)($t0)	#timer
	sub $t3, $t2, $t1
	slt $t3, $t3, $t4
	bnez $t2, framespersecond_while
	lui $t1, %hi(frame_last_used_at)
	sw $t2, %lo(frame_last_used_at)($t1)
	#end
	addi $sp, $sp, 4
	lw $ra, -4($sp)
	jr $ra