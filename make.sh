#!/bin/sh

nasm -f bin bootsector.asm
dd if=/dev/zero of=tmp1 bs=512 count=2879
cp bootsector image.vfd
cat tmp1 >> image.vfd
rm -rf tmp1
