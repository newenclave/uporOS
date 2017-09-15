nasm start.asm -f bin -o boot.bin
cat boot.bin ../kernel/kernel.bin > bootload.bin
qemu-system-x86_64 -fda bootload.bin
