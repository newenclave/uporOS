
C_SOURCES = ${wildcard kernel/*.c drivers/*.c}
HEADERS   = ${wildcard kernel/*.h drivers/*.h}
OBJ       = ${C_SOURCES:.c=.o}
QEMU 	  = qemu-system-x86_64

run: all	
	${QEMU} -fda image.bin

all: image

image: boot/bootsec.bin kernel.bin
	cat $^ > image.bin

%.o: %.c ${HEADERS}
	gcc -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -I"boot/" -o $@

kernel.bin: kernel/entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

clean:
	rm -fr *.o *.bin
	rm -fr kernel/*.o kernel/*.bin drivers/*.o drivers/*.bin boot/*.bin

