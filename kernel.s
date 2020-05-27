	.file	"kernel.c"
	.text
	.align 16
	.globl	drawtile
	.type	drawtile, @function
drawtile:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$4, %esp
	.cfi_def_cfa_offset 24
	movsbl	32(%esp), %ebx
	movl	24(%esp), %eax
	movzbl	28(%esp), %edi
	movsbl	36(%esp), %esi
	movl	%eax, (%esp)
	leal	8(%ebx), %ebp
	.align 16
.L2:
	xorl	%eax, %eax
	.align 16
.L4:
	movl	(%esp), %ecx
	cmpb	$48, (%ecx,%eax,8)
	jne	.L3
	leal	(%esi,%eax), %edx
	movl	%edi, %ecx
	leal	(%edx,%edx,4), %edx
	sall	$6, %edx
	movb	%cl, 655360(%ebx,%edx)
.L3:
	addl	$1, %eax
	cmpl	$8, %eax
	jne	.L4
	addl	$1, %ebx
	addl	$1, (%esp)
	cmpl	%ebp, %ebx
	jne	.L2
	addl	$4, %esp
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE0:
	.size	drawtile, .-drawtile
	.align 16
	.globl	putfont
	.type	putfont, @function
putfont:
.LFB1:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	movl	8(%esp), %ebx
	xorl	%edx, %edx
	.align 16
.L18:
	movl	y, %eax
	movl	x, %ecx
	addl	%edx, %eax
	leal	(%eax,%eax,4), %eax
	sall	$6, %eax
	leal	655360(%eax,%ecx), %ecx
	movzbl	(%ebx,%edx), %eax
	testb	%al, %al
	jns	.L10
	movb	$15, (%ecx)
.L10:
	testb	$64, %al
	je	.L11
	movb	$15, 1(%ecx)
.L11:
	testb	$32, %al
	je	.L12
	movb	$15, 2(%ecx)
.L12:
	testb	$16, %al
	je	.L13
	movb	$15, 3(%ecx)
.L13:
	testb	$8, %al
	je	.L14
	movb	$15, 4(%ecx)
.L14:
	testb	$4, %al
	je	.L15
	movb	$15, 5(%ecx)
.L15:
	testb	$2, %al
	je	.L16
	movb	$15, 6(%ecx)
.L16:
	testb	$1, %al
	je	.L17
	movb	$15, 7(%ecx)
.L17:
	addl	$1, %edx
	cmpl	$10, %edx
	jne	.L18
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE1:
	.size	putfont, .-putfont
	.align 16
	.globl	printhankaku
	.type	printhankaku, @function
printhankaku:
.LFB2:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	movl	8(%esp), %ebx
	movzbl	(%ebx), %eax
	testb	%al, %al
	je	.L42
	.align 16
.L45:
	sall	$4, %eax
	addl	$font, %eax
	pushl	%eax
	.cfi_def_cfa_offset 12
	call	putfont
	movl	x, %eax
	popl	%edx
	.cfi_def_cfa_offset 8
	addl	$8, %eax
	cmpl	$320, %eax
	movl	%eax, x
	jne	.L44
	addl	$9, y
.L44:
	addl	$1, %ebx
	movzbl	(%ebx), %eax
	testb	%al, %al
	jne	.L45
.L42:
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE2:
	.size	printhankaku, .-printhankaku
	.align 16
	.globl	init_vga
	.type	init_vga, @function
init_vga:
.LFB3:
	.cfi_startproc
	subl	$52, %esp
	.cfi_def_cfa_offset 56
	movl	$19, %eax
	movw	%ax, 28(%esp)
	leal	14(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 60
	pushl	$16
	.cfi_def_cfa_offset 64
	call	int32
	addl	$60, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE3:
	.size	init_vga, .-init_vga
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"!@#$%^&*()_+-=~[]|}:?><},./|"
.LC1:
	.string	"abcdefghijklmnopqrstuvwxyz"
.LC2:
	.string	"123$4567890"
	.text
	.align 16
	.globl	kernel_main
	.type	kernel_main, @function
kernel_main:
.LFB4:
	.cfi_startproc
	subl	$52, %esp
	.cfi_def_cfa_offset 56
	movl	$19, %eax
	movw	%ax, 28(%esp)
	leal	14(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 60
	pushl	$16
	.cfi_def_cfa_offset 64
	call	int32
	movl	$.LC0, (%esp)
	call	printhankaku
	movl	$.LC1, (%esp)
	call	printhankaku
	movl	$.LC2, (%esp)
	call	printhankaku
	addl	$60, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE4:
	.size	kernel_main, .-kernel_main
	.globl	y
	.section	.bss
	.align 4
	.type	y, @object
	.size	y, 4
y:
	.zero	4
	.globl	x
	.align 4
	.type	x, @object
	.size	x, 4
x:
	.zero	4
	.ident	"GCC: (GNU) 7.1.0"
