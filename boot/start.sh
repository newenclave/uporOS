nasm start.asm -f bin -o boot.bin
cat boot.bin tmp/kernel.bin > bootload.bin
qemu-system-x86_64 bootload.bin
