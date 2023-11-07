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
	.section	.mprjram,"ax",@progbits
	.align	2
	.globl	initfir
	.type	initfir, @function
initfir:
.LFB0:
	.file 1 "fir.c"
	.loc 1 3 61
	.cfi_startproc
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sw	s0,28(sp)
	.cfi_offset 8, -4
	addi	s0,sp,32
	.cfi_def_cfa 8, 0
	.loc 1 5 3
	li	a5,805306368
	addi	a5,a5,16
	.loc 1 5 36
	lui	a4,%hi(data_length)
	lw	a4,%lo(data_length)(a4)
	sw	a4,0(a5)
.LBB2:
	.loc 1 6 10
	sw	zero,-20(s0)
	.loc 1 6 2
	j	.L2
.L3:
	.loc 1 7 37 discriminator 3
	lw	a4,-20(s0)
	li	a5,201326592
	addi	a5,a5,8
	add	a5,a4,a5
	slli	a5,a5,2
	.loc 1 7 5 discriminator 3
	mv	a3,a5
	.loc 1 7 50 discriminator 3
	lui	a5,%hi(taps)
	addi	a4,a5,%lo(taps)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	.loc 1 7 44 discriminator 3
	sw	a5,0(a3)
	.loc 1 6 20 discriminator 3
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L2:
	.loc 1 6 15 discriminator 1
	lw	a4,-20(s0)
	li	a5,10
	ble	a4,a5,.L3
.LBE2:
	.loc 1 9 12
	lui	a5,%hi(reg_fir_x)
	sw	zero,%lo(reg_fir_x)(a5)
	.loc 1 10 12
	lui	a5,%hi(reg_fir_y)
	sw	zero,%lo(reg_fir_y)(a5)
	.loc 1 11 18
	lui	a5,%hi(outputbuffer)
	sw	zero,%lo(outputbuffer)(a5)
	.loc 1 12 1
	nop
	lw	s0,28(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 32
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE0:
	.size	initfir, .-initfir
	.align	2
	.globl	start
	.type	start, @function
start:
.LFB1:
	.loc 1 14 59
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	s0,12(sp)
	.cfi_offset 8, -4
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	.loc 1 18 45
	li	a5,805306368
	lw	a4,0(a5)
	.loc 1 18 5
	li	a5,805306368
	.loc 1 18 78
	ori	a4,a4,1
	.loc 1 18 40
	sw	a4,0(a5)
	.loc 1 22 1
	nop
	lw	s0,12(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE1:
	.size	start, .-start
	.align	2
	.globl	input
	.type	input, @function
input:
.LFB2:
	.loc 1 24 59
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	s0,12(sp)
	.cfi_offset 8, -4
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	.loc 1 28 5
	li	a5,805306368
	addi	a5,a5,128
	.loc 1 28 38
	lui	a4,%hi(reg_fir_x)
	lw	a4,%lo(reg_fir_x)(a4)
	sw	a4,0(a5)
	.loc 1 32 1
	nop
	lw	s0,12(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE2:
	.size	input, .-input
	.align	2
	.globl	output
	.type	output, @function
output:
.LFB3:
	.loc 1 34 60
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	s0,12(sp)
	.cfi_offset 8, -4
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	.loc 1 38 17
	li	a5,805306368
	addi	a5,a5,132
	lw	a4,0(a5)
	.loc 1 38 14
	lui	a5,%hi(reg_fir_y)
	sw	a4,%lo(reg_fir_y)(a5)
	.loc 1 42 1
	nop
	lw	s0,12(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE3:
	.size	output, .-output
	.align	2
	.globl	fir
	.type	fir, @function
fir:
.LFB4:
	.loc 1 44 56
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
	.loc 1 46 2
	call	initfir
	.loc 1 49 2
	call	start
.LBB3:
	.loc 1 52 19
	li	s1,0
	.loc 1 52 2
	j	.L8
.L9:
	.loc 1 53 13 discriminator 3
	lui	a5,%hi(reg_fir_x)
	sw	s1,%lo(reg_fir_x)(a5)
	.loc 1 56 3 discriminator 3
	call	input
	.loc 1 59 3 discriminator 3
	call	output
	.loc 1 52 38 discriminator 3
	addi	s1,s1,1
.L8:
	.loc 1 52 24 discriminator 1
	lui	a5,%hi(data_length)
	lw	a5,%lo(data_length)(a5)
	blt	s1,a5,.L9
.LBE3:
	.loc 1 61 19
	lui	a5,%hi(reg_fir_y)
	lw	a4,%lo(reg_fir_y)(a5)
	lui	a5,%hi(outputbuffer)
	sw	a4,%lo(outputbuffer)(a5)
	.loc 1 62 10
	lui	a5,%hi(outputbuffer)
	addi	a5,a5,%lo(outputbuffer)
	.loc 1 63 2
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
.LFE4:
	.size	fir, .-fir
	.text
.Letext0:
	.file 2 "fir.h"
	.file 3 "/opt/riscv/lib/gcc/riscv32-unknown-elf/12.1.0/include/stdint-gcc.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x174
	.2byte	0x5
	.byte	0x1
	.byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x8
	.4byte	.LASF19
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
	.byte	0x9
	.4byte	.LASF20
	.byte	0x3
	.byte	0x28
	.byte	0x12
	.4byte	0x40
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
	.byte	0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF8
	.byte	0x1
	.byte	0x8
	.byte	0x7
	.4byte	.LASF9
	.byte	0xa
	.byte	0x4
	.byte	0x5
	.string	"int"
	.byte	0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF10
	.byte	0x2
	.4byte	.LASF11
	.byte	0x7
	.4byte	0x6a
	.byte	0x5
	.byte	0x3
	.4byte	data_length
	.byte	0x4
	.4byte	0x6a
	.4byte	0x98
	.byte	0x5
	.4byte	0x71
	.byte	0xa
	.byte	0
	.byte	0x2
	.4byte	.LASF12
	.byte	0x8
	.4byte	0x88
	.byte	0x5
	.byte	0x3
	.4byte	taps
	.byte	0x2
	.4byte	.LASF13
	.byte	0x9
	.4byte	0x6a
	.byte	0x5
	.byte	0x3
	.4byte	reg_fir_x
	.byte	0x2
	.4byte	.LASF14
	.byte	0xa
	.4byte	0x6a
	.byte	0x5
	.byte	0x3
	.4byte	reg_fir_y
	.byte	0x4
	.4byte	0x6a
	.4byte	0xd8
	.byte	0x5
	.4byte	0x71
	.byte	0
	.byte	0
	.byte	0x2
	.4byte	.LASF15
	.byte	0xb
	.4byte	0xc8
	.byte	0x5
	.byte	0x3
	.4byte	outputbuffer
	.byte	0xb
	.string	"fir"
	.byte	0x1
	.byte	0x2c
	.byte	0x33
	.4byte	0x118
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.byte	0x1
	.byte	0x9c
	.4byte	0x118
	.byte	0x6
	.4byte	.LBB3
	.4byte	.LBE3-.LBB3
	.byte	0x7
	.string	"i"
	.byte	0x34
	.byte	0x13
	.4byte	0x6a
	.byte	0x1
	.byte	0x59
	.byte	0
	.byte	0
	.byte	0xc
	.byte	0x4
	.4byte	0x6a
	.byte	0x3
	.4byte	.LASF16
	.byte	0x22
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.byte	0x1
	.byte	0x9c
	.byte	0x3
	.4byte	.LASF17
	.byte	0x18
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.byte	0x1
	.byte	0x9c
	.byte	0x3
	.4byte	.LASF18
	.byte	0xe
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.byte	0x1
	.byte	0x9c
	.byte	0xd
	.4byte	.LASF21
	.byte	0x1
	.byte	0x3
	.byte	0x33
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.byte	0x1
	.byte	0x9c
	.byte	0x6
	.4byte	.LBB2
	.4byte	.LBE2-.LBB2
	.byte	0x7
	.string	"i"
	.byte	0x6
	.byte	0xa
	.4byte	0x6a
	.byte	0x2
	.byte	0x91
	.byte	0x6c
	.byte	0
	.byte	0
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
	.byte	0x2
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
	.byte	0x2e
	.byte	0
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0x21
	.byte	0x1
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
	.byte	0x4
	.byte	0x1
	.byte	0x1
	.byte	0x49
	.byte	0x13
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x5
	.byte	0x21
	.byte	0
	.byte	0x49
	.byte	0x13
	.byte	0x2f
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0x6
	.byte	0xb
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0
	.byte	0
	.byte	0x7
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0x21
	.byte	0x1
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x8
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
	.byte	0x9
	.byte	0x16
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xa
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
	.byte	0xb
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
	.byte	0xc
	.byte	0xf
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xd
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
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x3c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
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
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x6
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x6
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x6
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x6
	.4byte	.LFB4
	.4byte	.LFE4
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF21:
	.string	"initfir"
.LASF18:
	.string	"start"
.LASF6:
	.string	"unsigned char"
.LASF17:
	.string	"input"
.LASF8:
	.string	"long unsigned int"
.LASF7:
	.string	"short unsigned int"
.LASF15:
	.string	"outputbuffer"
.LASF19:
	.string	"GNU C17 12.1.0 -mabi=ilp32 -mtune=rocket -misa-spec=2.2 -march=rv32i -g -ffreestanding"
.LASF10:
	.string	"unsigned int"
.LASF12:
	.string	"taps"
.LASF9:
	.string	"long long unsigned int"
.LASF13:
	.string	"reg_fir_x"
.LASF14:
	.string	"reg_fir_y"
.LASF20:
	.string	"int32_t"
.LASF5:
	.string	"long long int"
.LASF3:
	.string	"short int"
.LASF11:
	.string	"data_length"
.LASF4:
	.string	"long int"
.LASF2:
	.string	"signed char"
.LASF16:
	.string	"output"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"fir.c"
.LASF1:
	.string	"/home/ubuntu/SoC_Design/Lab4_2/testbench/counter_la_fir"
	.ident	"GCC: (g1ea978e3066) 12.1.0"
