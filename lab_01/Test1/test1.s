	.file	"test1.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d"
.LC1:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	leaq	4(%rsp), %rsi
	leaq	.LC0(%rip), %rdi
	call	__isoc99_scanf@PLT
	movl	$1, %edx
	movl	$2, %eax
	jmp	.L2
.L3:
	imull	%eax, %edx
	addl	$1, %eax
.L2:
	cmpl	%eax, 4(%rsp)
	jge	.L3
	leaq	.LC1(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	8(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L6
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L6:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
