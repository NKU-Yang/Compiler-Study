.section  .rodata
.LC0:
      .string "%d"
.LC1:
      .string "%d\n"
#main function
.text
.globl main
.type  main, @function
main:
.LFB23:
      #Allocate 24 bytes on stack
      subq  $24, %rsp
      #set %eax 0
      movl  $0,%eax
      leaq  4(%rsp),%rsi
      #Allocate the address of LC0 to rdi
      leaq  .LC0(%rip),%rdi
      call  __isoc99_scanf@PLT
      movl $1,%edx
      movl $2,%ecx
      jmp .L2
.L3:
      imull %ecx,%edx
      addl  $1, %ecx
.L2:
      cmpl %ecx, 4(%rsp)
      jge  .L3
      leaq .LC1(%rip),%rsi
      call __printf_chk@PLT
      addq $24, %rsp
      ret
.section        .note.GNU-stack,"",@progbits
      
