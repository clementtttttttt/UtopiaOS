 all:
	i686-elf-as boot.s -o boot.o
	i686-elf-gcc -S kernel.c -o kernel.s -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	i686-elf-as kernel.s -o kernel.o
	nasm -felf32 include/rmode.asm -o rmode.o
	nasm -felf32 include/asmfunc.asm -o asmfunc.o
	i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o asmfunc.o kernel.o rmode.o -lgcc
	grub-file --is-x86-multiboot myos.bin
	mkdir -p isodir/boot/grub
	cp myos.bin isodir/boot/myos.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o myos.iso isodir
	qemu-system-i386 -cdrom myos.iso
