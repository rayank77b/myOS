

xor ax,ax       ; set video modus: 80x25
mov al, 03h
int 10h

mov ah, 9  ; Write instruction for int 0x10
mov al, 64 ; A
mov bh, 0  ; Page number
mov bl, 4  ; Red on black (00000100 - High 0000 is black, low 0100 is red)
mov cx, 2  ; Writes one character
int 0x10
mov ah, 9  ; Write instruction for int 0x10
mov al, 65 ; A
mov bh, 0  ; Page number
mov bl, 4  ; Red on black (00000100 - High 0000 is black, low 0100 is red)
mov cx, 3  ; Writes one character
int 0x10
mov ah, 9  ; Write instruction for int 0x10
mov al, 66 ; A
mov bh, 0  ; Page number
mov bl, 4  ; Red on black (00000100 - High 0000 is black, low 0100 is red)
mov cx, 4  ; Writes one character
int 0x10
mov ah, 9  ; Write instruction for int 0x10
mov al, 41 ; A
mov bh, 0  ; Page number
mov bl, 4  ; Red on black (00000100 - High 0000 is black, low 0100 is red)
mov cx, 5  ; Writes one character
int 0x10



times 510-($-$$) db 0	; Pad remainder of boot sector with 0s
dw 0xAA55
