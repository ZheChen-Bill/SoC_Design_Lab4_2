	.file	"fir.c"
	.option nopic
	.attribute arch, "rv32i2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "/home/ubuntu/SoC_Design/Lab4_2/testbench/counter_la_fir" "fir.c"
	.globl	data_length
	.section	.sdata,"aw"
	.align	2
	.type	data_length, @object
	.size	data_length, 4
data_length:
	.word	64
	.globl	taps
	.data
	.align	2
	.type	taps, @object
	.size	taps, 44
taps:
	.word	0
	.word	-10
	.word	-9
	.word	23
	.word	56
	.word	63
	.word	56
	.word	23
	.word	-9
	.word	-10
	.word	0
	.globl	reg_fir_x
	.section	.sbss,"aw",@nobits
	.align	2
	.type	reg_fir_x, @object
	.size	reg_fir_x, 4
reg_fir_x:
	.zero	4
	.globl	reg_fir_y
	.align	2
	.type	reg_fir_y, @object
	.size	reg_fir_y, 4
reg_fir_y:
	.zero	4
	.globl	outputbuffer
	.align	2
	.type	outputbuffer, @object
	.size	outputbuffer, 4
outputbuffer:
	.zero	4
	.text
	.align	2
	.type	flush_cpu_icache, @function
flush_cpu_icache:
.LFB21:
	.file 1 "../../firmware/system.h"
	.loc 1 15 1
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	s0,12(sp)
	.cfi_offset 8, -4
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	.loc 1 26 1
	nop
	lw	s0,12(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE21:
	.size	flush_cpu_icache, .-flush_cpu_icache
	.align	2
	.type	flush_cpu_dcache, @function
flush_cpu_dcache:
.LFB22:
	.loc 1 29 1
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	s0,12(sp)
	.cfi_offset 8, -4
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	.loc 1 33 1
	nop
	lw	s0,12(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE22:
	.size	flush_cpu_dcache, .-flush_cpu_dcache
	.section	.mprjram,"ax",@progbits
	.align	2
	.globl	initfir
	.type	initfir, @function
initfir:
.LFB316:
	.file 2 "fir.c"
	.loc 2 4 61
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	s0,12(sp)
	sw	s1,8(sp)
	.cfi_offset 8, -4
	.cfi_offset 9, -8
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	.loc 2 6 3
	li	a5,805306368
	addi	a5,a5,16
	.loc 2 6 36
	lui	a4,%hi(data_length)
	lw	a4,%lo(data_length)(a4)
	sw	a4,0(a5)
.LBB2:
	.loc 2 7 19
	li	s1,0
	.loc 2 7 2
	j	.L4
.L5:
	.loc 2 8 37 discriminator 3
	li	a5,201326592
	addi	a5,a5,8
	add	a5,s1,a5
	slli	a5,a5,2
	.loc 2 8 5 discriminator 3
	mv	a3,a5
	.loc 2 8 50 discriminator 3
	lui	a5,%hi(taps)
	addi	a4,a5,%lo(taps)
	slli	a5,s1,2
	add	a5,a4,a5
	lw	a5,0(a5)
	.loc 2 8 44 discriminator 3
	sw	a5,0(a3)
	.loc 2 7 29 discriminator 3
	addi	s1,s1,1
.L4:
	.loc 2 7 24 discriminator 1
	li	a5,10
	ble	s1,a5,.L5
.LBE2:
	.loc 2 10 12
	lui	a5,%hi(reg_fir_x)
	sw	zero,%lo(reg_fir_x)(a5)
	.loc 2 11 12
	lui	a5,%hi(reg_fir_y)
	sw	zero,%lo(reg_fir_y)(a5)
	.loc 2 12 18
	lui	a5,%hi(outputbuffer)
	sw	zero,%lo(outputbuffer)(a5)
	.loc 2 13 1
	nop
	lw	s0,12(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	lw	s1,8(sp)
	.cfi_restore 9
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE316:
	.size	initfir, .-initfir
	.align	2
	.globl	start
	.type	start, @function
start:
.LFB317:
	.loc 2 15 59
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	s0,12(sp)
	.cfi_offset 8, -4
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
.L9:
	.loc 2 18 10
	li	a5,805306368
	lw	a5,0(a5)
	.loc 2 18 43
	andi	a4,a5,4
	.loc 2 18 6
	li	a5,4
	bne	a4,a5,.L9
	.loc 2 19 45
	li	a5,805306368
	lw	a4,0(a5)
	.loc 2 19 5
	li	a5,805306368
	.loc 2 19 78
	ori	a4,a4,1
	.loc 2 19 40
	sw	a4,0(a5)
	.loc 2 20 4
	nop
	.loc 2 23 1
	nop
	lw	s0,12(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE317:
	.size	start, .-start
	.align	2
	.globl	input
	.type	input, @function
input:
.LFB318:
	.loc 2 25 59
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	s0,12(sp)
	.cfi_offset 8, -4
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	.loc 2 29 5
	li	a5,805306368
	addi	a5,a5,128
	.loc 2 29 38
	lui	a4,%hi(reg_fir_x)
	lw	a4,%lo(reg_fir_x)(a4)
	sw	a4,0(a5)
	.loc 2 33 1
	nop
	lw	s0,12(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE318:
	.size	input, .-input
	.align	2
	.globl	output
	.type	output, @function
output:
.LFB319:
	.loc 2 35 60
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	s0,12(sp)
	.cfi_offset 8, -4
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	.loc 2 39 17
	li	a5,805306368
	addi	a5,a5,132
	lw	a4,0(a5)
	.loc 2 39 14
	lui	a5,%hi(reg_fir_y)
	sw	a4,%lo(reg_fir_y)(a5)
	.loc 2 43 1
	nop
	lw	s0,12(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE319:
	.size	output, .-output
	.align	2
	.globl	fir
	.type	fir, @function
fir:
.LFB320:
	.loc 2 45 56
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	ra,12(sp)
	sw	s0,8(sp)
	sw	s1,4(sp)
	.cfi_offset 1, -4
	.cfi_offset 8, -8
	.cfi_offset 9, -12
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	.loc 2 47 2
	call	initfir
	.loc 2 50 2
	call	start
.LBB3:
	.loc 2 52 19
	li	s1,0
	.loc 2 52 2
	j	.L14
.L15:
	.loc 2 53 13 discriminator 3
	lui	a5,%hi(reg_fir_x)
	sw	s1,%lo(reg_fir_x)(a5)
	.loc 2 56 3 discriminator 3
	call	input
	.loc 2 59 3 discriminator 3
	call	output
	.loc 2 52 38 discriminator 3
	addi	s1,s1,1
.L14:
	.loc 2 52 24 discriminator 1
	lui	a5,%hi(data_length)
	lw	a5,%lo(data_length)(a5)
	blt	s1,a5,.L15
.LBE3:
	.loc 2 61 48
	lui	a5,%hi(reg_fir_y)
	lw	a5,%lo(reg_fir_y)(a5)
	slli	a4,a5,16
	.loc 2 61 3
	li	a5,637534208
	addi	a5,a5,12
	.loc 2 61 36
	sw	a4,0(a5)
	.loc 2 62 49
	lui	a5,%hi(reg_fir_y)
	lw	a5,%lo(reg_fir_y)(a5)
	slli	a4,a5,24
	.loc 2 62 54
	li	a5,5898240
	or	a4,a4,a5
	.loc 2 62 3
	li	a5,637534208
	addi	a5,a5,12
	.loc 2 62 36
	sw	a4,0(a5)
	.loc 2 64 3
	li	a5,637534208
	addi	a5,a5,12
	.loc 2 64 36
	li	a4,10813440
	sw	a4,0(a5)
	.loc 2 65 2
	call	start
.LBB4:
	.loc 2 67 19
	li	s1,0
	.loc 2 67 2
	j	.L16
.L17:
	.loc 2 68 13 discriminator 3
	lui	a5,%hi(reg_fir_x)
	sw	s1,%lo(reg_fir_x)(a5)
	.loc 2 71 3 discriminator 3
	call	input
	.loc 2 74 3 discriminator 3
	call	output
	.loc 2 67 38 discriminator 3
	addi	s1,s1,1
.L16:
	.loc 2 67 24 discriminator 1
	lui	a5,%hi(data_length)
	lw	a5,%lo(data_length)(a5)
	blt	s1,a5,.L17
.LBE4:
	.loc 2 76 48
	lui	a5,%hi(reg_fir_y)
	lw	a5,%lo(reg_fir_y)(a5)
	slli	a4,a5,16
	.loc 2 76 3
	li	a5,637534208
	addi	a5,a5,12
	.loc 2 76 36
	sw	a4,0(a5)
	.loc 2 77 49
	lui	a5,%hi(reg_fir_y)
	lw	a5,%lo(reg_fir_y)(a5)
	slli	a4,a5,24
	.loc 2 77 54
	li	a5,5898240
	or	a4,a4,a5
	.loc 2 77 3
	li	a5,637534208
	addi	a5,a5,12
	.loc 2 77 36
	sw	a4,0(a5)
	.loc 2 79 3
	li	a5,637534208
	addi	a5,a5,12
	.loc 2 79 36
	li	a4,10813440
	sw	a4,0(a5)
	.loc 2 80 2
	call	start
.LBB5:
	.loc 2 82 19
	li	s1,0
	.loc 2 82 2
	j	.L18
.L19:
	.loc 2 83 13 discriminator 3
	lui	a5,%hi(reg_fir_x)
	sw	s1,%lo(reg_fir_x)(a5)
	.loc 2 86 3 discriminator 3
	call	input
	.loc 2 89 3 discriminator 3
	call	output
	.loc 2 82 38 discriminator 3
	addi	s1,s1,1
.L18:
	.loc 2 82 24 discriminator 1
	lui	a5,%hi(data_length)
	lw	a5,%lo(data_length)(a5)
	blt	s1,a5,.L19
.LBE5:
	.loc 2 91 49
	lui	a5,%hi(reg_fir_y)
	lw	a5,%lo(reg_fir_y)(a5)
	slli	a4,a5,16
	.loc 2 91 4
	li	a5,637534208
	addi	a5,a5,12
	.loc 2 91 37
	sw	a4,0(a5)
	.loc 2 92 50
	lui	a5,%hi(reg_fir_y)
	lw	a5,%lo(reg_fir_y)(a5)
	slli	a4,a5,24
	.loc 2 92 55
	li	a5,5898240
	or	a4,a4,a5
	.loc 2 92 4
	li	a5,637534208
	addi	a5,a5,12
	.loc 2 92 37
	sw	a4,0(a5)
	.loc 2 93 19
	lui	a5,%hi(reg_fir_y)
	lw	a4,%lo(reg_fir_y)(a5)
	lui	a5,%hi(outputbuffer)
	sw	a4,%lo(outputbuffer)(a5)
	.loc 2 94 10
	lui	a5,%hi(outputbuffer)
	addi	a5,a5,%lo(outputbuffer)
	.loc 2 95 2
	mv	a0,a5
	lw	ra,12(sp)
	.cfi_restore 1
	lw	s0,8(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	lw	s1,4(sp)
	.cfi_restore 9
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE320:
	.size	fir, .-fir
	.text
.Letext0:
	.file 3 "/opt/riscv/lib/gcc/riscv32-unknown-elf/12.1.0/include/stdint-gcc.h"
	.file 4 "fir.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x1cf
	.2byte	0x5
	.byte	0x1
	.byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0xb
	.4byte	.LASF23
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.4byte	.LLRL0
	.4byte	0
	.4byte	.Ldebug_line0
	.byte	0x1
	.byte	0x1
	.byte	0x6
	.4byte	.LASF2
	.byte	0x1
	.byte	0x2
	.byte	0x5
	.4byte	.LASF3
	.byte	0x5
	.4byte	.LASF8
	.byte	0x28
	.byte	0x12
	.4byte	0x3f
	.byte	0x1
	.byte	0x4
	.byte	0x5
	.4byte	.LASF4
	.byte	0x1
	.byte	0x8
	.byte	0x5
	.4byte	.LASF5
	.byte	0x1
	.byte	0x1
	.byte	0x8
	.4byte	.LASF6
	.byte	0x1
	.byte	0x2
	.byte	0x7
	.4byte	.LASF7
	.byte	0x5
	.4byte	.LASF9
	.byte	0x34
	.byte	0x1b
	.4byte	0x66
	.byte	0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF10
	.byte	0x1
	.byte	0x8
	.byte	0x7
	.4byte	.LASF11
	.byte	0xc
	.byte	0x4
	.byte	0x5
	.string	"int"
	.byte	0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF12
	.byte	0x2
	.4byte	.LASF13
	.byte	0x7
	.4byte	0x74
	.byte	0x5
	.byte	0x3
	.4byte	data_length
	.byte	0x6
	.4byte	0x74
	.4byte	0xa2
	.byte	0x7
	.4byte	0x7b
	.byte	0xa
	.byte	0
	.byte	0x2
	.4byte	.LASF14
	.byte	0x8
	.4byte	0x92
	.byte	0x5
	.byte	0x3
	.4byte	taps
	.byte	0x2
	.4byte	.LASF15
	.byte	0x9
	.4byte	0x74
	.byte	0x5
	.byte	0x3
	.4byte	reg_fir_x
	.byte	0x2
	.4byte	.LASF16
	.byte	0xa
	.4byte	0x74
	.byte	0x5
	.byte	0x3
	.4byte	reg_fir_y
	.byte	0x6
	.4byte	0x74
	.4byte	0xe2
	.byte	0x7
	.4byte	0x7b
	.byte	0
	.byte	0
	.byte	0x2
	.4byte	.LASF17
	.byte	0xb
	.4byte	0xd2
	.byte	0x5
	.byte	0x3
	.4byte	outputbuffer
	.byte	0xd
	.string	"fir"
	.byte	0x2
	.byte	0x2d
	.byte	0x33
	.4byte	0x151
	.4byte	.LFB320
	.4byte	.LFE320-.LFB320
	.byte	0x1
	.byte	0x9c
	.4byte	0x151
	.byte	0x8
	.4byte	.LBB3
	.4byte	.LBE3-.LBB3
	.4byte	0x124
	.byte	0x3
	.string	"i"
	.byte	0x34
	.4byte	0x74
	.byte	0x1
	.byte	0x59
	.byte	0
	.byte	0x8
	.4byte	.LBB4
	.4byte	.LBE4-.LBB4
	.4byte	0x13c
	.byte	0x3
	.string	"i"
	.byte	0x43
	.4byte	0x74
	.byte	0x1
	.byte	0x59
	.byte	0
	.byte	0x9
	.4byte	.LBB5
	.4byte	.LBE5-.LBB5
	.byte	0x3
	.string	"i"
	.byte	0x52
	.4byte	0x74
	.byte	0x1
	.byte	0x59
	.byte	0
	.byte	0
	.byte	0xe
	.byte	0x4
	.4byte	0x74
	.byte	0x4
	.4byte	.LASF18
	.byte	0x23
	.4byte	.LFB319
	.4byte	.LFE319-.LFB319
	.byte	0x1
	.byte	0x9c
	.byte	0x4
	.4byte	.LASF19
	.byte	0x19
	.4byte	.LFB318
	.4byte	.LFE318-.LFB318
	.byte	0x1
	.byte	0x9c
	.byte	0x4
	.4byte	.LASF20
	.byte	0xf
	.4byte	.LFB317
	.4byte	.LFE317-.LFB317
	.byte	0x1
	.byte	0x9c
	.byte	0xf
	.4byte	.LASF24
	.byte	0x2
	.byte	0x4
	.byte	0x33
	.4byte	.LFB316
	.4byte	.LFE316-.LFB316
	.byte	0x1
	.byte	0x9c
	.4byte	0x1b2
	.byte	0x9
	.4byte	.LBB2
	.4byte	.LBE2-.LBB2
	.byte	0x3
	.string	"i"
	.byte	0x7
	.4byte	0x74
	.byte	0x1
	.byte	0x59
	.byte	0
	.byte	0
	.byte	0xa
	.4byte	.LASF21
	.byte	0x1c
	.4byte	.LFB22
	.4byte	.LFE22-.LFB22
	.byte	0x1
	.byte	0x9c
	.byte	0xa
	.4byte	.LASF22
	.byte	0xe
	.4byte	.LFB21
	.4byte	.LFE21-.LFB21
	.byte	0x1
	.byte	0x9c
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.byte	0x1
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0
	.byte	0
	.byte	0x2
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0x21
	.byte	0x4
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0x21
	.byte	0x5
	.byte	0x49
	.byte	0x13
	.byte	0x3f
	.byte	0x19
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x3
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0x21
	.byte	0x2
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0x21
	.byte	0x13
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x4
	.byte	0x2e
	.byte	0
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0x21
	.byte	0x2
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0x21
	.byte	0x33
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7a
	.byte	0x19
	.byte	0
	.byte	0
	.byte	0x5
	.byte	0x16
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0x21
	.byte	0x3
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x6
	.byte	0x1
	.byte	0x1
	.byte	0x49
	.byte	0x13
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x7
	.byte	0x21
	.byte	0
	.byte	0x49
	.byte	0x13
	.byte	0x2f
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0x8
	.byte	0xb
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x9
	.byte	0xb
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0
	.byte	0
	.byte	0xa
	.byte	0x2e
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0x21
	.byte	0x1
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0x21
	.byte	0x25
	.byte	0x27
	.byte	0x19
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7a
	.byte	0x19
	.byte	0
	.byte	0
	.byte	0xb
	.byte	0x11
	.byte	0x1
	.byte	0x25
	.byte	0xe
	.byte	0x13
	.byte	0xb
	.byte	0x3
	.byte	0x1f
	.byte	0x1b
	.byte	0x1f
	.byte	0x55
	.byte	0x17
	.byte	0x11
	.byte	0x1
	.byte	0x10
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0xc
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0x8
	.byte	0
	.byte	0
	.byte	0xd
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7c
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xe
	.byte	0xf
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xf
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7a
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x44
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.LFB316
	.4byte	.LFE316-.LFB316
	.4byte	.LFB317
	.4byte	.LFE317-.LFB317
	.4byte	.LFB318
	.4byte	.LFE318-.LFB318
	.4byte	.LFB319
	.4byte	.LFE319-.LFB319
	.4byte	.LFB320
	.4byte	.LFE320-.LFB320
	.4byte	0
	.4byte	0
	.section	.debug_rnglists,"",@progbits
.Ldebug_ranges0:
	.4byte	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.2byte	0x5
	.byte	0x4
	.byte	0
	.4byte	0
.LLRL0:
	.byte	0x6
	.4byte	.Ltext0
	.4byte	.Letext0
	.byte	0x6
	.4byte	.LFB316
	.4byte	.LFE316
	.byte	0x6
	.4byte	.LFB317
	.4byte	.LFE317
	.byte	0x6
	.4byte	.LFB318
	.4byte	.LFE318
	.byte	0x6
	.4byte	.LFB319
	.4byte	.LFE319
	.byte	0x6
	.4byte	.LFB320
	.4byte	.LFE320
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF24:
	.string	"initfir"
.LASF20:
	.string	"start"
.LASF21:
	.string	"flush_cpu_dcache"
.LASF6:
	.string	"unsigned char"
.LASF19:
	.string	"input"
.LASF10:
	.string	"long unsigned int"
.LASF7:
	.string	"short unsigned int"
.LASF17:
	.string	"outputbuffer"
.LASF23:
	.string	"GNU C17 12.1.0 -mabi=ilp32 -mtune=rocket -misa-spec=2.2 -march=rv32i -g -ffreestanding"
.LASF12:
	.string	"unsigned int"
.LASF14:
	.string	"taps"
.LASF11:
	.string	"long long unsigned int"
.LASF22:
	.string	"flush_cpu_icache"
.LASF15:
	.string	"reg_fir_x"
.LASF16:
	.string	"reg_fir_y"
.LASF8:
	.string	"int32_t"
.LASF5:
	.string	"long long int"
.LASF3:
	.string	"short int"
.LASF13:
	.string	"data_length"
.LASF9:
	.string	"uint32_t"
.LASF4:
	.string	"long int"
.LASF2:
	.string	"signed char"
.LASF18:
	.string	"output"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"fir.c"
.LASF1:
	.string	"/home/ubuntu/SoC_Design/Lab4_2/testbench/counter_la_fir"
	.ident	"GCC: (g1ea978e3066) 12.1.0"
