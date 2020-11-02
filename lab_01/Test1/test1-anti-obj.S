
test1.o：     文件格式 elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	48 83 ec 20          	sub    $0x20,%rsp
   8:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
   f:	00 00 
  11:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  15:	31 c0                	xor    %eax,%eax
  17:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
  1b:	48 89 c6             	mov    %rax,%rsi
  1e:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 25 <main+0x25>
  25:	b8 00 00 00 00       	mov    $0x0,%eax
  2a:	e8 00 00 00 00       	callq  2f <main+0x2f>
  2f:	c7 45 f0 02 00 00 00 	movl   $0x2,-0x10(%rbp)
  36:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
  3d:	eb 0e                	jmp    4d <main+0x4d>
  3f:	8b 45 f4             	mov    -0xc(%rbp),%eax
  42:	0f af 45 f0          	imul   -0x10(%rbp),%eax
  46:	89 45 f4             	mov    %eax,-0xc(%rbp)
  49:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
  4d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  50:	39 45 f0             	cmp    %eax,-0x10(%rbp)
  53:	7e ea                	jle    3f <main+0x3f>
  55:	8b 45 f4             	mov    -0xc(%rbp),%eax
  58:	89 c6                	mov    %eax,%esi
  5a:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 61 <main+0x61>
  61:	b8 00 00 00 00       	mov    $0x0,%eax
  66:	e8 00 00 00 00       	callq  6b <main+0x6b>
  6b:	90                   	nop
  6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  70:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
  77:	00 00 
  79:	74 05                	je     80 <main+0x80>
  7b:	e8 00 00 00 00       	callq  80 <main+0x80>
  80:	c9                   	leaveq 
  81:	c3                   	retq   
