 AS=i686-elf-as
 NASM=nasm
 NFLAGS=-felf32 
 CC=i686-elf-gcc
 LD=i686-elf-gcc
 CFLAGS=-std=gnu99 -ffreestanding -O2 -Wall -Wextra -fpermissive
 LFLAGS=-T linker.ld -ffreestanding -O2 -nostdlib -lgcc

 obj := $(patsubst %.c,%.o,$(wildcard *.c)) boot.o $(patsubst include/%.asm,%.o2,$(wildcard include/*.asm))
all: myos.iso
 
%.s: %.c
	$(CC) -S -o $@ $< $(CFLAGS)
%.o: %.s
	$(AS) -o $@ $<
%.o2: include/%.asm 
	$(NASM) -o $@ $< $(NFLAGS)

myos.bin: $(obj)
	$(LD) -o $@ *.o *.o2 $(LFLAGS)
myos.iso:myos.bin
	grub-file --is-x86-multiboot myos.bin
	mkdir -p isodir/boot/grub
	cp myos.bin isodir/boot/myos.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o myos.iso isodir
test:
	qemu-system-i386 myos.iso
clean:
	rm *.o 
	rm *.o2
	rm *.iso
