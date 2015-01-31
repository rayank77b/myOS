; kernel.asm
; our kernel is 8kB big

BITS 16
org 7e00h                   ; our Kernel live in 7E00 Adresse 

%INCLUDE "macros/print.inc"

call print_newline
printLine strKernel



; init stack
mov eax, 0x7ffff
mov esp, eax
mov ebp, eax
printString strESP
push strESP
mov eax, esp
call outputEAX2Hex
call print_newline

; get RAM size
xor ax, ax
int 0x12
call outputEAX2Hex
call print_newline

jmp $

%INCLUDE "routines/print.asm"

strKernel       db 'Kernel Started...', 0
strESP          db 'ESP: ',0

times 8192-($-$$) db 0	
