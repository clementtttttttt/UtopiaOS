#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include "include/rmode.h"
#include "include/graphics.h"
#include "include/keyboard.h"
#include "include/asmfunc.h"
 #include "include/font.h"
#include <stdarg.h>
int *resolution_ptr;
extern void load_gdt();
void init_vbe(){
    regs16_t vberegister;
    regs16_t vberegs2;
  vberegister.bx=0x4107;
  vberegister.ax=0x4f02;
  int32(0x10,&vberegister);
    vberegs2.ax=0x4f01;
    vberegs2.cx=0x4107;
    vberegs2.di=0x3fe0;
    int32(0x10,&vberegs2);
  *resolution_ptr=1280;
}


void kernel_main(void) 
{
  
    
  unsigned char out;
  resolution_ptr=(int*)0x2ff0;
  init_vbe ();
    printstring("Kernel sucessfully loaded.");
    newline();
    initkeyboard();
    
}

