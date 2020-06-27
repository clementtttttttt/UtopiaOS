 AS=i686-elf-as
 NASM=nasm
 NFLAGS=-felf32 
 CC=i686-elf-gcc
 LD=i686-elf-gcc
 CFLAGS=-std=gnu99 -ffreestanding -O2 -Wall -Wextra -fpermissive -B./ -I /usr/include/multiboot
 LFLAGS=-T linker.ld -ffreestanding -O2 -nostdlib -lgcc

 obj := $(patsubst %.c,%.o,$(wildcard *.c)) $(patsubst %.asm,%.o2,$(wildcard *.asm))
all: myos.iso

%.o: %.c %.h 
	$(CC) -c -o $@ $< $(CFLAGS)
%.o2: %.asm
	$(NASM) -o $@ $< $(NFLAGS)
myos.bin: $(obj)
	$(LD) -o $@ *.o *.o2 $(LFLAGS)
myos.iso:myos.bin
	grub-file --is-x86-multiboot myos.bin
	mkdir -p isodir/boot/grub
	cp myos.bin isodir/boot/myos.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o myos.iso isodir
test: myos.iso	
	qemu-system-i386 myos.iso
clean:
	-rm *.o 
	-rm *.o2
	-rm *.iso
