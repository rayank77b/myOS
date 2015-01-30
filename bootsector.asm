BITS 16

start:
org 7c00h           ; we set our offset to RAM 7c00

mov si, myName	; Put string position into SI
call print_string	; Call our string-printing routine

jmp $			    ; Jump here - infinite loop!


myName db 'myOS starting...', 0

; Routine: output string in SI to screen
; argv: SI pointer to string
print_string:			
	mov ah, 0Eh		    ; int 10h 'print char' function
.repeat:
	lodsb			    ; Get character from string
	cmp al, 0
	je .done		    ; If char is zero, end of string
	int 10h			    ; Otherwise, print it
	jmp .repeat
.done:
	ret

times 510-($-$$) db 0	; Pad remainder of boot sector with 0s
dw 0xAA55
