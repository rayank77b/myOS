BITS 16
org 7c00h                   ; we set our offset to RAM 0x7c00

;%INCLUDE "macros/print.inc"
; we dont output to save bootsector space

; main

;printLine strMyName

;printLine strRDStatus

xor ax, ax
mov es, ax    ; ES <- 0
mov cx, 1     ; cylinder 0, sector 1
mov dx, 0080h ; DH = 0 (head), drive = 80h (0th hard disk)
mov bx, 7e00h ; segment offset of the buffer
mov ax, 0201h ; AH = 02 (disk read), AL = 01 (number of sectors to read)
int 13h       
; test we write it
;mov si, strDiskOk
;add si, 200h
;call print_string

xor ax, ax
mov es, ax    ; ES <- 0
mov cx, 2     ; cylinder 0, sector 1
mov dx, 0080h ; DH = 0 (head), drive = 80h (0th hard disk)
mov bx, 7e00h ; segment offset of the buffer
mov ax, 0210h ; AH = 02 (disk read), AL = 10 (number of sectors to read)
int 13h       ; read 16*512=8kB of data to memory

jmp 7e00h			            ; jump to kernel

;%INCLUDE "routines/print.asm"

; data -------------------------------------------------------------------------
strMyName       db 'myOS starting...', 0
diskNumber      db 0,0
strRDStatus     db 'Read Disk Status:..', 0
strDiskFail     db 'disk fail', 0
strDiskOk       db 'disk ok',0



times 510-($-$$) db 0	
dw 0xAA55
