[ORG 0x7c00]

hang:
    hlt
    jmp hang

times 510-($-$$) db 0	; fill rest with zeros
dw	 0xAA55		; magic byte