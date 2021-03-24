https://wiki.osdev.org/Bare_Bones

you need croscompiler
https://wiki.osdev.org/GCC_Cross-Compiler


boot.s - kernel entry point that sets up the processor environment
kernel.c - your actual kernel routines
linker.ld - for linking the above files 


export PREFIX="path/to/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"
export PATH="path/to/cross/bin:$PATH"



# build boot file
i686-elf-as boot.s -o boot.o

# build kernel
i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

# link boot and kernel
i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

# boot the kernel in multiboot
qemu-system-i386 -kernel myos.bin



# boot with iso
grub.cfg
menuentry "myos" {
	multiboot /boot/myos.bin
}

mkdir -p isodir/boot/grub
cp myos.bin isodir/boot/myos.bin
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o myos.iso isodir

# start
qemu-system-i386 -cdrom myos.iso

# QEMU supports booting multiboot kernels directly without bootable medium
qemu-system-i386 -kernel myos.bin