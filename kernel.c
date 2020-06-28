#include <multiboot.h>
multiboot_info_t* public_mbd;
#include <stdint.h>
#include "include/font.h"
void initidt();
void *keyboardbuffer=(short*)0x2fe0;
void kernel_main(multiboot_info_t* mbd,unsigned int magic){
    long *vramptr=mbd->framebuffer_addr;
    public_mbd=mbd;
    printstring("Starting UtopiaOS...");
    newline();
    printstring("Segment Register,text engine and GDT initialized.\n");
    newline();
    printstring("[Interrupt Initialize Routine]");
    newline();
    initidt();
    printstring("OK");
    while(1){
        if(keyboardbuffer!=0){
            printstring(keyboardbuffer);
        }
            
    }
}
