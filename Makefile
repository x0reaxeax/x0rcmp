equ: equ.o
        ld -N -o equ equ.o

equ.o: equ.asm
        nasm -f elf64 equ.asm

clean:
        rm -f equ equ.o
