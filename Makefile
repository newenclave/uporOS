
C_SOURCES = ${wildcard kernel/*.c drivers/*.c}
HEADERS   = ${wildcard kernel/*.h drivers/*.h}
OBJ       = ${C_SOURCES:.c=.o}

QEMU 	  = qemu-system-x86_64
CC        = gcc
ASMC      = nasm
LD        = ld

run: all
	${QEMU} -fda image.bin

all: image

image: boot/bootsec.bin kernel.bin
	cat $^ > image.bin

%.o: %.c ${HEADERS}
	${CC} -ffreestanding -c $< -o $@

%.o: %.asm
	${ASMC} $< -f elf -o $@

%.bin: %.asm
	${ASMC} $< -f bin -I"boot/" -o $@

kernel.bin: kernel/entry.o ${OBJ}
	${LD} -o $@ -Ttext 0x1000 $^ --oformat binary

clean:
	rm -fr *.o *.bin
	rm -fr kernel/*.o kernel/*.bin drivers/*.o drivers/*.bin boot/*.bin

