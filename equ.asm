; equality check
; usage ./equ digit1 digit2

global _start

section .data
    val1    dd  1

_ptrbuf:
    times   256 dq _buffer

section .bss
    _buffer resq 256

section .text

%macro CLEANUP 0
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
%endmacro

%macro IF_THEN 4
    CLEANUP
    xor rbx, %3
    xor rax, [_ptrbuf]
    xor [_ptrbuf], rax
    xor [_ptrbuf], rbx
    xor cl, %2
    xor cl, %1
    xor rdx,  [_ptrbuf+rcx*1*8]
    xor dil, %4
    xor eax, eax
    xor al, [rdx]
    xor [rdx], al
    xor [rdx], dil
    CLEANUP
%endmacro


_start:
    xor rsi, [rsp+16]   ; argv[1]
    xor r8b, [rsi]      ; argv[1][0]
    xor r8b, 0x30       ; argv[1][0] ^ 0x30

    xor r9, [rsp+24]    ; argv[2]
    xor r10b, [r9]      ; argv[2][0] ^ 0x30
    xor r10b, 0x30      ; argv[2][0] ^ 0x30

    ; UINT8 if_then(const UINT8 cmp1, const UINT8 cmp2, UINT8 *var1, const UINT8 imm32);
    IF_THEN r8b, r10b, val1, 42

    xor eax, eax
    xor edi, edi
    xor eax, 0x3c       ; 0x3c = sys_exit

    xor rcx, label1     ; load address of `xor eax, eax` (0x31, 0xc0) at label1

    xor ebx, ebx
    xor ebx, 0x3e
    xor [rcx], bl       ; 0x31 ^ 0x3e = 0x0f

    xor ebx, ebx
    xor ebx, 0xc5
    xor [rcx+1], bl     ; 0xc0 ^ 0xc5 = 0x05
    
    xor dil, [val1]
label1:
    xor eax, eax        ; this is now 0x0f, 0x05 (syscall)
