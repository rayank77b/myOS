; kernel.asm
; our kernel is 8kB big

BITS 16
org 7e00h                   ; our Kernel live in 7E00 Adresse 

%INCLUDE "macros/print.inc"

    ; init stack
    cli	                    ; clear interrupts
    mov eax, 0x7ffff        ; our stack life on 0x7ffff top of free memory
    mov esp, eax
    mov ebp, eax
    sti                     ; restore interrupts
    cld                     ; The default direction for string operations
					        ; will be 'up' - incrementing address
 
    call print_newline      ; out put info
    printLine strKernel
    printString strESP
    push strESP
    mov eax, esp
    call outputEAX2Hex
    call print_newline
    
    xor ax, ax              ; get RAM size
    int 0x12                ; we ge ram size in eax
    call outputEAX2Hex
    call print_newline


jmp $

%INCLUDE "routines/print.asm"

strKernel       db 'Kernel Started...', 0
strESP          db 'ESP: ',0

times 8192-($-$$) db 0	
