; Declare constants for the multiboot header.
MBALIGN  equ  1 << 0            ; align loaded modules on page boundaries
MEMINFO  equ  1 << 1            ; provide memory map
FLAGS    equ  0b00000000000000000000000000000111; this is the Multiboot 'flag' field
MAGIC    equ  0x1BADB002        ; 'magic number' lets bootloader find the header
CHECKSUM equ -(MAGIC + FLAGS)   ; checksum of above, to prove we are multiboot
 	extern kernel_main
 	extern printstring

; Declare a multiboot header that marks the program as a kernel. These are magic
; values that are documented in the multiboot standard. The bootloader will
; search for this signature in the first 8 KiB of the kernel file, aligned at a
; 32-bit boundary. The signature is in its own section so the header can be
; forced to be within the first 8 KiB of the kernel file.
section .multiboot
align 4
	dd MAGIC
	dd FLAGS
	dd CHECKSUM
    dd 0
    dd 0
    dd 0
    dd 0
    dd 0
    dd 0
    dd 2560
    dd 1600
    dd 8
; The multiboot standard does not define the value of the stack pointer register
; (esp) and it is up to the kernel to provide a stack. This allocates room for a
; small stack by creating a symbol at the bottom of it, then allocating 16384
; bytes for it, and finally creating a symbol at the top. The stack grows
; downwards on x86. The stack is in its own section so it can be marked nobits,
; which means the kernel file is smaller because it does not contain an
; uninitialized stack. The stack on x86 must be 16-byte aligned according to the
; System V ABI standard and de-facto extensions. The compiler will assume the
; stack is properly aligned and failure to align the stack will result in
; undefined behavior.
section .bss
align 16
stack_bottom:
resb 16384; 16 KiB
stack_top:
 
; The linker script specifies _start as the entry point to the kernel and the
; bootloader will jump to this position once the kernel has been loaded. It
; doesn't make sense to return from this function as the bootloader is gone.
; Declare _start as a function symbol with the given symbol size.
section .text
global _start:function (_start.end - _start)
_start:
    cli
    mov [grub_eax],eax
    mov [grub_ebx],ebx
	; The bootloader has loaded us into 32-bit protected mode on a x86
	; machine. Interrupts are disabled. Paging is disabled. The processor
	; state is as defined in the multiboot standard. The kernel has full
	; control of the CPU. The kernel can only make use of hardware features
	; and any code it provides as part of itself. There's no printf
	; function, unless the kernel provides its own <stdio.h> header and a
	; printf implementation. There are no security restrictions, no
	; safeguards, no debugging mechanisms, only what the kernel provides
	; itself. It has absolute and complete power over the
	; machine.
 
	; To set up a stack, we set the esp register to point to the top of our
	; stack (as it grows downwards on x86 systems). This is necessarily done
	; in assembly as languages such as C cannot function without a stack.
	
 .load_the_gdt:
    lgdt [gdtinfo]
    jmp 0x8:.fix_segrs
 .fix_segrs:
    mov ax,0x10
    mov ds,ax
    mov es,ax
    mov fs,ax
    mov gs,ax
    mov ss,ax
	mov esp, stack_top

.main_kernel_stuff:

    push dword [grub_eax]
	push dword [grub_ebx]
  call kernel_main
    
	; If the system has nothing more to do, put the computer into an
	; infinite loop. To do that:
	; 1) Disable interrupts with cli (clear interrupt enable in eflags).
	;    They are already disabled by the bootloader, so this is not needed.
	;    Mind that you might later enable interrupts and return from
	;    kernel_main (which is sort of nonsensical to do).
	; 2) Wait for the next interrupt to arrive with hlt (halt instruction).
	;    Since they are disabled, this will lock up the computer.
	; 3) Jump to the hlt instruction if it ever wakes up due to a
	;    non-maskable interrupt occurring or due to system management mode.
    
.hang:	
    hlt
	jmp .hang
.end:

section .kernel_gdt_and_idt
    gdtinfo:
         dw end_of_gdt-gdt-1
         dd gdt
    
    gdt:
        .nullentry dd 0,0
        .fcode db 0xff,0xff,0,0,0,10011010b,11001111b,0
        .fdata db 0xff,0xff,0,0,0,10010010b,11001111b,0
    end_of_gdt:
        
    grub_eax dd 0
    grub_ebx dd 0
    
    idtinfo:
        dw end_of_idt-idt-1
        dd idt
    idt:
        times 20h dq 0
        timer_entry:
            .t_lbit dw 0
            .cs_s dw 0x08
            .reserv db 0
            .type db 0x8e
            .t_hbit dw 0
        keyboard_entry:
            .k_lbit dw 0
            .cs_s   dw 0x08
            .reserv db 0
            .type   db 0x8e
            .k_hbit dw 0
    end_of_idt:
section .interrupt_handlers
    timer:
        pusha
        mov al,0x20
        out 0x20,al
        popa
        iret
    int21h:
        pusha
        in al,60h
        mov [0x2fe0],al
        mov al,0x20
        out 0x20,al
        
        popa
        iret
section .kernel_secondary_code
global initidt
    initidt:
        .pic_remap:
            cli
            mov al,11h
            out 0x20,al
            call iowait
            out 0xa0,al
            call iowait
            mov al,20h
            out 0x21,al
            call iowait
            mov al,28h
            out 0xa1,al
            call iowait
            mov al,4
            out 0x21,al
            sub al,2
            call iowait
            out 0xa1,al
            call iowait
            mov al,1
            out 0x21,al
            call iowait
            out 0xa1,al
            call iowait
            mov eax,0xffff
            and eax,int21h
            mov [keyboard_entry.k_lbit],ax
            mov eax,0xffff0000
            and eax,int21h
            shr eax,16
            mov [keyboard_entry.k_hbit],ax
            mov eax,0xffff
            and eax,timer
            mov [timer_entry.t_lbit],ax
            mov eax,0xffff0000
            and eax,timer
            shr eax,16
            mov [timer_entry.t_hbit],ax
            lidt [idtinfo]
            sti
            
    ret
    iowait:
        jmp .1
        .1:
        jmp .2
        .2:
        ret
