global main
extern printf

; Outside comment
section .rodata
code db "global main%1$cextern printf%1$c%1$c; Outside comment%1$csection .rodata%1$ccode db %2$c%3$s%2$c, 0%1$c%1$csection .text%1$cmain:%1$c    lea rdi, [rel code]%1$c    mov rsi, 10%1$c    mov rdx, 34%1$c    lea rcx, [rel code]%1$c    xor eax, eax ; Variadic # of XMM%1$c    sub rsp, 8 ; Alignment%1$c    call printf%1$c    add rsp, 8%1$c    xor eax, eax%1$c    ret%1$c%1$c", 0

section .text
main:
    lea rdi, [rel code]
    mov rsi, 10
    mov rdx, 34
    lea rcx, [rel code]
    xor eax, eax ; Variadic # of XMM
    sub rsp, 8 ; Alignment
    call printf
    add rsp, 8
    xor eax, eax
    ret
