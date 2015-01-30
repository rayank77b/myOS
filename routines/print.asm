; Routrines --------------------------------------------------------------------

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

; print a newline
print_newline:
	mov ah, 0Eh
	mov al, 13
	int 10h
	mov al, 10
	int 10h
	ret
; Routrines -------------------------------------------------------------------
