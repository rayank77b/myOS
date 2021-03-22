
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
    movzx bx, byte[xpos]
    mov cx, bx      ; for count
    shl bx, 1       ; x2
    movzx ax, byte[ypos]
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