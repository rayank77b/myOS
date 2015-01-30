#!/bin/sh

echo "[+] build bootsector..."
nasm -f bin bootsector.asm || exit

echo "[+] build kernel..." 
nasm -f bin kernel.asm || exit

echo "[+] build 1440kB image..."
dd if=/dev/zero of=tmp1 bs=512 count=2863

echo "[+] concate..."
cp bootsector image.vfd
cat kernel >> image.vfd
cat tmp1 >> image.vfd

rm -rf tmp1

echo "[+] done"
