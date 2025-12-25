global main
extern strrchr
extern strchr
extern snprintf
extern dprintf
extern system

O_WRONLY equ 0b1
O_CREAT equ 0b100
O_TRUNC equ 0b1000

section .rodata
fname db "Sully_%d.s", 0
cmd db "nasm -f elf64 Sully_%1$d.s -o Sully_%1$d; ./Sully_%1$d", 0
code db "",0

section .text
main:
    enter 192, 0 ; fname, cmd
    push  r12    ; i
    push  r13    ; fd

    mov   r12d, 5
    mov   rdi, [rsi + 8] ; rdi = filename
    mov   esi, '/'
    call  strrchr
    test  rax, rax
    jz    .no_path
    lea   rdi, [rax + 1]
    jmp   .check_name

.no_path:
    mov   rdi, [rsi + 8]

.check_name:
    mov   esi, '_'
    call  strchr
    test  rax, rax
    jz    .check_var
    sub   r12d, 1

.check_var:
    cmp   r12d, 0
    jl    .error

    lea   rdi, [rbp - 64] ; fname
    mov   esi, 64
    lea   rdx, [rel fname]
    mov   ecx, r12d
    xor   eax, eax
    call  snprintf

    lea   rdi, [rbp - 64]
    mov   rsi, O_WRONLY
    or    rsi, O_CREAT
    or    rsi, O_TRUNC
    mov   edx, 0o644
    mov   eax, 2          ; open
    syscall
    cmp   eax, 0
    jl    .error
    mov   r13d, eax        ; r13d = fd

    lea   rdi, [rbp - 192] ; cmd
    mov   esi, 128
    lea   rdx, [rel cmd]
    mov   ecx, r12d
    xor   eax, eax
    call  snprintf

    mov   edi, r13d
    lea   rsi, [rel code]
    mov   edx, 10
    mov   ecx, r12d
    mov   r8d, 34
    lea   r9, [rel code]
    xor   eax, eax
    call  dprintf

    lea   rdi, [rbp - 192]
    call  system
    jmp   .done

.error:
    mov   eax, 1
    jmp   .return

.done:
    mov  edi, r13d
    mov  eax, 3     ; close
    syscall
    xor  eax, eax

.return:
    pop   r13
    pop   r12
    leave
    ret
