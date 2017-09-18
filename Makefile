
C_SOURCES = ${wildcard kernel/*.c drivers/*.c}
HEADERS   = ${wildcard kernel/*.h drivers/*.h}
OBJ       = ${C_SOURCES:.c=.o}

QEMU 	  = qemu-system-x86_64
CC        = gcc
ASMC      = nasm
LD        = ld

all: image

run: all
	${QEMU} -fda image.bin

image: boot/bootsec.bin kernel.bin
	cat $^ > image.bin

%.o: %.c ${HEADERS}
	${CC} -ffreestanding -c -fno-pie -m32 -I"./" $< -o $@

%.o: %.asm
	${ASMC} $< -f elf32 -o $@

%.bin: %.asm
	${ASMC} $< -f bin -I"boot/" -o $@

kernel.bin: kernel_entry.o ${OBJ}
	${LD} -o $@ -Ttext 0x1000 -m elf_i386 $^ --oformat binary

kernel_entry.o: kernel/kernel_entry.asm
	${ASMC} $< -f elf32 -o $@

clean:
	rm -fr *.o *.bin
	rm -fr kernel/*.o kernel/*.bin drivers/*.o drivers/*.bin boot/*.bin

