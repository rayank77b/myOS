# myOS
my simple OS in real mode with NASM

phase One:
*  testing only in qemu
*  simple real modus
*  only Assembler
*  simple output
*  simple file input with write to disk file

our memory layout is real mode, we dont use segments

0x7c00 - 0x7dff  boot sector
0x7e00 - 0x9dff  kernel 8k Memory (thus kernel should not be bigger as 8kb)

0x0007FFFF is our upper segment stack


file is 1440 kB big  2880 512Byte sectors

Sector 0:  bootloader
Sector 1-16: kernel,  16 sectors -> 8kByte
Sector 100-x: command file to execute
