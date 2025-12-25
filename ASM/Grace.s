global main
extern fprintf
extern fopen

section .rodata
mode_w db "w", 0
filename db "Grace_kid.c", 0
code db "global main%1$cextern printf%1$cextern fopen%1$c%1$csection .rodata%1$cmode_w db %2$cw%2$c, 0%1$cfilename db %2$cGrace_kid.c%2$c, 0%1$c%1$ccode db %2$c%3$s%2$c, 0%1$c%macro OPEN_FILE 2%1$c    lea rdi, [rel %1]%1$c    lea rsi, [rel %2]%1$c    call fopen wrt ..plt%1$c%endmacro%1$c%1$c%macro PRINT 0%1$c    mov  rdi, rax%1$c    lea  rsi, [rel code]%1$c    mov  edx, 10%1$c    mov  ecx, 34%1$c    lea  r8,  [rel code]%1$c    xor  eax, eax ; Variadic # of XMM%1$c    call fprintf wrt ..plt%1$c%endmacro%1$c%1$c%macro RUN 0%1$c    enter 0, 0%1$c    OPEN_FILE filename mode_w%1$c    PRINT%1$c    leave%1$c    xor eax, eax%1$c    ret%1$c%endmacro%1$c%1$csection .text%1$cmain:%1$c    RUN%1$c", 0

%macro OPEN_FILE 2
    lea rdi, [rel %1]
    lea rsi, [rel %2]
    call fopen wrt ..plt
%endmacro

%macro PRINT 0
    mov  rdi, rax
    lea  rsi, [rel code]
    mov  edx, 10
    mov  ecx, 34
    lea  r8,  [rel code]
    xor  eax, eax ; Variadic # of XMM
    call fprintf wrt ..plt
%endmacro

%macro RUN 0
    enter 0, 0
    OPEN_FILE filename mode_w
    PRINT
    leave
    xor eax, eax
    ret
%endmacro

section .text
main:
    RUN
