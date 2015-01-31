#!/bin/sh

# we booting from harddisk 

# network ne2k_isa
#-netdev user,id=usernet -device ne2k_isa,irq=5,netdev=userneta
# -net nic,model=ne2k_isa
qemu -m 4 -hda image.vfd 
