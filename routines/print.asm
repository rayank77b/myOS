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

; print a space
print_space:
	mov ah, 0Eh
	mov al, 20
	int 10h
	ret

; print a newline
print_newline:
	mov ah, 0Eh
	mov al, 13
	int 10h
	mov al, 10
	int 10h
	ret

outputEAX2Hex:
    push edx
    xor edx, edx
    mov edx, eax
    mov eax, '0'
    call puts_byte
    mov eax, 'x'
    call puts_byte
    mov eax, edx
    shr eax, 28
    and eax, 0x0000000f
    call convert4Bit
    call puts_byte
    mov eax, edx
    shr eax, 24
    and eax, 0x0000000f
    call convert4Bit
    call puts_byte
    mov eax, edx
    shr eax, 20
    and eax, 0x0000000f
    call convert4Bit
    call puts_byte
    mov eax, edx
    shr eax, 16
    and eax, 0x0000000f
    call convert4Bit
    call puts_byte
    mov eax, edx
    shr eax, 12
    and eax, 0x0000000f
    call convert4Bit
    call puts_byte
    mov eax, edx
    shr eax, 8
    and eax, 0x0000000f
    call convert4Bit
    call puts_byte
    mov eax, edx
    shr eax, 4
    and eax, 0x0000000f
    call convert4Bit
    call puts_byte
    mov eax, edx
    and eax, 0x0000000f
    call convert4Bit
    call puts_byte
    pop edx
    ret

; print a byte
; al has the byte
puts_byte:
    ; al, has the byte
    mov ah, 0Eh
	int 10h
	ret
	
convert4Bit:
    ; we get our 4 bit in low al 
    ; we return a 8 bit ascii code in al
    and al, 0x0f
    cmp al, 9
    jg biger9
    add al, 30h
    ret
biger9:
    add al, 37h
    ret
; Routrines -------------------------------------------------------------------
