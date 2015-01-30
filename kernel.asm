; kernel.asm
; our kernel is 8kB big

BITS 16
org 7e00h                   ; our Kernel live in 7E00 Adresse 

%INCLUDE "macros/print.inc"

printLine strKernel

jmp $

%INCLUDE "routines/print.asm"

strKernel       db 'Kernel Started...', 0

times 8192-($-$$) db 0	
