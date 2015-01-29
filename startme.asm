
; set video modus: 80x25
xor ax,ax
mov al, 03h
int 10h

mov ah, 9  ; Write instruction for int 0x10
mov al, 61 ; A
mov bh, 0  ; Page number
mov bl, 4  ; Red on black (00000100 - High 0000 is black, low 0100 is red)
mov cx, 1  ; Writes one character
int 0x10
