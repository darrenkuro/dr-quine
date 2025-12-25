global main
extern strrchr, strchr, snprintf, dprintf, system

INIT_VAR    equ 5
CMD_SIZE    equ 128
FNAME_SIZE  equ 64
OPEN_FLAG   equ 0o1101 ;  O_WRONLY | O_CREAT | O_TRUNC
OPEN_PERM   equ 0o644
CMD_OFF     equ CMD_SIZE
FNAME_OFF   equ CMD_OFF + FNAME_SIZE
FRAME_SIZE  equ CMD_SIZE + FNAME_SIZE

%define OPEN_SYS    2
%define CLOSE_SYS   3
%define CMD_MEM     [rbp - CMD_OFF]
%define FNAME_MEM   [rbp - FNAME_OFF]

section .rodata
fname db "Sully_%d.s", 0
cmd db "nasm -f elf64 Sully_%1$d.s -o Sully_%1$d.o && cc Sully_%1$d.o -o Sully_%1$d; ./Sully_%1$d", 0
code db "global main%1$cextern strrchr, strchr, snprintf, dprintf, system%1$c%1$cINIT_VAR    equ %3$d%1$cCMD_SIZE    equ 128%1$cFNAME_SIZE  equ 64%1$cOPEN_FLAG   equ 0o1101 ;  O_WRONLY | O_CREAT | O_TRUNC%1$cOPEN_PERM   equ 0o644%1$cCMD_OFF     equ CMD_SIZE%1$cFNAME_OFF   equ CMD_OFF + FNAME_SIZE%1$cFRAME_SIZE  equ CMD_SIZE + FNAME_SIZE%1$c%1$c%%define OPEN_SYS    2%1$c%%define CLOSE_SYS   3%1$c%%define CMD_MEM     [rbp - CMD_OFF]%1$c%%define FNAME_MEM   [rbp - FNAME_OFF]%1$c%1$csection .rodata%1$cfname db %2$cSully_%%d.s%2$c, 0%1$ccmd db %2$cnasm -f elf64 Sully_%%1$d.s -o Sully_%%1$d.o && cc Sully_%%1$d.o -o Sully_%%1$d; ./Sully_%%1$d%2$c, 0%1$ccode db %2$c%4$s%2$c, 0%1$c%1$c%%macro SRC_CHECK 2     ; Check if need to decrement or execute%1$c    mov   %%1, %%2%1$c    mov   r13, [rsi]   ; r13 = bin_name_full (save before call)%1$c    mov   rdi, r13%1$c    mov   esi, '/'%1$c    call  strrchr      ; strrchr(bin_name_full, '/')%1$c    test  rax, rax%1$c    jz    .no_path%1$c    lea   rdi, [rax+1] ; rdi = bin_name w/o path%1$c    jmp   .check_name%1$c%1$c.no_path:%1$c    mov   rdi, r13     ; rdi = bin_name w/o path%1$c%1$c.check_name:%1$c    mov   esi, '_'%1$c    call  strchr       ; strchr(bin_name, '_')%1$c    test  rax, rax%1$c    jz    .check_var%1$c    sub   %%1, 1%1$c%1$c.check_var:%1$c    cmp   %%1, 0%1$c    jl    .error%1$c%%endmacro%1$c%1$c%%macro OPEN 2          ; name, fd%1$c    lea   rdi, %%1%1$c    mov   rsi, OPEN_FLAG%1$c    mov   edx, OPEN_PERM%1$c    mov   eax, OPEN_SYS%1$c    syscall%1$c    cmp   eax, 0%1$c    jl    .error%1$c    mov   %%2, eax%1$c%%endmacro%1$c%1$c%%macro DPRINTF 3       ; fd, i, str%1$c    mov   edi, %%1%1$c    lea   rsi, [rel %%3]%1$c    mov   edx, 10%1$c    mov   ecx, '%2$c'%1$c    mov   r8d, %%2%1$c    lea   r9, [rel %%3]%1$c    xor   eax, eax%1$c    call  dprintf%1$c%%endmacro%1$c%1$c%%macro SNPRINTF 3      ; addr, size, str%1$c    lea   rdi, %%1%1$c    mov   esi, %%2%1$c    lea   rdx, [rel %%3]%1$c    mov   ecx, r12d%1$c    xor   eax, eax%1$c    call  snprintf%1$c%%endmacro%1$c%1$csection .text%1$cmain:%1$c    enter FRAME_SIZE, 0%1$c    push  r12%1$c    push  r13%1$c%1$c    SRC_CHECK r12d, INIT_VAR%1$c%1$c    SNPRINTF FNAME_MEM, FNAME_SIZE, fname%1$c    OPEN FNAME_MEM, r13d%1$c    SNPRINTF CMD_MEM, CMD_SIZE, cmd%1$c    DPRINTF r13d, r12d, code%1$c%1$c    lea  rdi, CMD_MEM%1$c    call system%1$c    jmp  .done%1$c%1$c.error:%1$c    mov  eax, 1%1$c    jmp  .return%1$c%1$c.done:%1$c    mov  edi, r13d%1$c    mov  eax, CLOSE_SYS%1$c    syscall%1$c    xor  eax, eax%1$c%1$c.return:%1$c    pop  r13%1$c    pop  r12%1$c    leave%1$c    ret%1$c", 0

%macro SRC_CHECK 2     ; Check if need to decrement or execute
    mov   %1, %2
    mov   r13, [rsi]   ; r13 = bin_name_full (save before call)
    mov   rdi, r13
    mov   esi, '/'
    call  strrchr      ; strrchr(bin_name_full, '/')
    test  rax, rax
    jz    .no_path
    lea   rdi, [rax+1] ; rdi = bin_name w/o path
    jmp   .check_name

.no_path:
    mov   rdi, r13     ; rdi = bin_name w/o path

.check_name:
    mov   esi, '_'
    call  strchr       ; strchr(bin_name, '_')
    test  rax, rax
    jz    .check_var
    sub   %1, 1

.check_var:
    cmp   %1, 0
    jl    .error
%endmacro

%macro OPEN 2          ; name, fd
    lea   rdi, %1
    mov   rsi, OPEN_FLAG
    mov   edx, OPEN_PERM
    mov   eax, OPEN_SYS
    syscall
    cmp   eax, 0
    jl    .error
    mov   %2, eax
%endmacro

%macro DPRINTF 3       ; fd, i, str
    mov   edi, %1
    lea   rsi, [rel %3]
    mov   edx, 10
    mov   ecx, '"'
    mov   r8d, %2
    lea   r9, [rel %3]
    xor   eax, eax
    call  dprintf
%endmacro

%macro SNPRINTF 3      ; addr, size, str
    lea   rdi, %1
    mov   esi, %2
    lea   rdx, [rel %3]
    mov   ecx, r12d
    xor   eax, eax
    call  snprintf
%endmacro

section .text
main:
    enter FRAME_SIZE, 0
    push  r12
    push  r13

    SRC_CHECK r12d, INIT_VAR

    SNPRINTF FNAME_MEM, FNAME_SIZE, fname
    OPEN FNAME_MEM, r13d
    SNPRINTF CMD_MEM, CMD_SIZE, cmd
    DPRINTF r13d, r12d, code

    lea  rdi, CMD_MEM
    call system
    jmp  .done

.error:
    mov  eax, 1
    jmp  .return

.done:
    mov  edi, r13d
    mov  eax, CLOSE_SYS
    syscall
    xor  eax, eax

.return:
    pop  r13
    pop  r12
    leave
    ret
