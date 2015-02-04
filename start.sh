#!/bin/sh

# we booting from harddisk 



qemu -m 4 -hda image.vfd 


# examples:
# network ne2k_isa
# -netdev user,id=usernet -device ne2k_isa,irq=5,netdev=userneta
# -net nic,model=ne2k_isa
# -serial file:serialoutput.txt
