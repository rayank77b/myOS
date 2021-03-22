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