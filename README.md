# myOS
my simple OS in real mode with NASM

phase One:
*  testing only in qemu
*  simple real modus
*  only Assembler
*  simple output
*  simple network

our memory layout is real mode, we dont use segments

0x7c00 - 0x7dff  boot sector
0x7e00 - 0x9dff  kernel 8k Memory (thus kernel should not be bigger as 8kb)

0x0007FFFF is our upper segment stack


