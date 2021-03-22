%include "macros.inc"

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
%include "print.inc"

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