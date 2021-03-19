;-----------------------------------------
; after bios we start at 0x7c00
[org 0x7c00]

; we are in realmode, set segment to zero
	xor ax, ax
	mov ds, ax
	mov ss, ax
	mov sp, 0x9c00	; we init a simple 8kB Stack 
    mov ax, 0xb800 ; init video buffer
    mov es, ax

    xor bx, bx
    mov ax, 0x0f41
    call putc
    mov ax, 0x0f42
    add bx, 2
    call putc

hang:
    hlt
    jmp hang


;---------------------------------------
; ah - bgcolor
; al - fgcolor
; bx - index
putc:
    mov [es:bx], ax
    ret


times 510-($-$$) db 0	; fill rest with zeros
dw	 0xAA55		; magic byte