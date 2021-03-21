%macro m_setpos 2
    xor ax, ax
    mov al, %1
    mov [xpos], al
    mov al, %2
    mov [ypos], al
%endmacro

%macro m_putc 2
    mov bx, %2   
    mov ax, %1
    call putc
%endmacro

%macro m_printk 1
    mov si, %1
    call printk
%endmacro

%macro m_printk_integer 1
    mov ax, %1
    call printk_integer
%endmacro


;----- Main --------------------------
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

    call cls

    ;m_putc 0x0f41,320   ; 2x160, A
    ;m_putc 0x0f42,322   ; next B

	m_setpos 0,1
    m_printk msg

    call scroll     ; simple test

    mov di, buffer
    mov bx, 0xABCD
    mov cx, 0x1234
    call print_registers

hang:
    hlt
    jmp hang

;--------- Functions --------------------

; scroll the screen one line up
scroll:
    push ax
    push si
    push di
    mov di, 0
    mov si, 160
scroll_loop:
    mov ax, [es:si]
    mov [es:di], ax
    add di, 2
    add si, 2
    cmp di, 4000    ; 80x25
    jne scroll_loop
    pop di
    pop si
    pop ax
    ret

; clear screen
cls:
    push ax
    push bx
    xor bx, bx
    mov ax, 0x0020 ; black space
cls_loop:
    mov [es:bx], ax
    add bx, 2
    cmp bx, 0x07d0
    jne cls_loop
    pop bx
    pop ax
    ret


; si - message address
printk:
    push ax
    push bx
    push dx
    push cx
    xor bx, bx
    mov bl, [xpos]
    mov cx, bx      ; for count
    shl bx, 1       ; x2
    xor ax, ax
    mov al, [ypos]
    mov dx, 160
    mul dx
    add ax, bx
    mov bx, ax
printk_load_next:
    lodsb           ; load to al, from [si]
    cmp al, 0
    je printk_end
    cmp al, 10      ; \n newline
    jne printk_next
    mov byte [xpos], 0
    xor cx, cx
    push ax
    xor ax, ax
    mov al, [ypos]
    add ax, 1
    mov [ypos], al
    mov dx, 160
    mul dx
    mov bx, ax
    pop ax
    jmp printk_load_next
printk_next:
    mov ah, 0x0f  ; black/white
    mov [es:bx], ax
    add bx, 2
    inc cx
    jmp printk_load_next
printk_end:
    mov [xpos], cl  ; save last x pos
    pop cx
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

; ax - integer to print out
printk_integer:
    push di
    push si
    push cx
    push bx
    mov cx, 4
    mov di, buffer+3
printk_integer_next:
    mov si, hex2char
    mov bx, ax
    and bx, 0x000f
    add si, bx
    mov bx, [si]
    mov byte [di], bl
    shr ax, 4
    dec di
    dec cx
    cmp cx, 0
    jne printk_integer_next
    mov si, bufferbegin
    call printk
    pop bx
    pop cx
    pop si
    pop di
    ret

; registers ausgeben
print_registers:
    push si
    m_printk msg_ax
    m_printk_integer ax
    m_printk msg_bx
    m_printk_integer bx
    m_printk msg_cx
    m_printk_integer cx
    m_printk msg_dx
    m_printk_integer dx
    m_printk msg_di
    m_printk_integer di
    m_printk msg_si
    m_printk_integer si
    call start_next
start_next:
    pop ax      ; store ip to bx
    m_printk msg_ip
    m_printk_integer ax
    pop si
    ret

;---------------------------------------
msg  db 'Hello Kernel. MyOS', 10, 'Version: 0.1', 10, 0

msg_ax db 10,'AX - ',0
msg_bx db 10,'BX - ',0
msg_cx db 10,'CX - ',0
msg_dx db 10,'DX - ',0
msg_di db 10,'DI - ',0
msg_si db 10,'SI - ',0
msg_ip db 10,'IP - ',0

hex2char db '0123456789ABCDEF'

xpos db 0       ; x-position in video buffer. is 2xbytes!
ypos db 0       ; column in video buffer.

bufferbegin db '0x'
buffer db 0,0,0,0   ; 4 bytes

times 510-($-$$) db 0	; fill rest with zeros
dw	 0xAA55		; magic byte