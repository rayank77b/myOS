%macro setpos 2
xor ax, ax
mov al, %1
mov [xpos], al
mov al, %2
mov [ypos], al
%endmacro

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

	cld	; clear direction
	cli	; deaktivate interrupts	

    mov bx, 320 ; 2x160
    mov ax, 0x0f41
    call putc
    mov ax, 0x0f42
    add bx, 2
    call putc

	setpos 4,12
    mov si, msg
    call printk

    setpos 0,24
    mov si, msg
    call printk

hang:
    hlt
    jmp hang


;---------------------------------------

; si - message address
printk:
    push ax
    push bx
    push dx
    xor ax, ax
    xor bx, bx
    mov bl, [xpos]
    shl bx, 1 ; x2
    mov al, [ypos]
    mov dx, 160
    mul dx
    add bx, ax
    mov ah, 0x0f ; black/white
printk_load_next:
    lodsb ; load to al, from [si]
    cmp al, 0
    je printk_end
    mov ah, 0x0f ; black/white
    mov [es:bx], ax
    add bx, 2
    jmp printk_load_next
printk_end:
    pop dx
    pop bx
    pop ax
    ret


; ah - bgcolor
; al - fgcolor
; bx - index
putc:
    mov [es:bx], ax
    ret

;---------------------------------------
xpos db 0       ; x-position in video buffer. is 2xbytes!
ypos db 0       ; column in video buffer.

msg db 'Hello Kernel. MyOS', 10, ' Version: 0.1', 10, 0


times 510-($-$$) db 0	; fill rest with zeros
dw	 0xAA55		; magic byte