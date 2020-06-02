#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include "include/rmode.h"
#include "include/graphics.h"
#include "include/keyboard.h"
#include "include/asmfunc.h"
 #include "include/font.h"
int *resolution_ptr;
  
void init_vga();
void init_vbe(){
    regs16_t vberegister;
  vberegister.bx=0x4107;
  vberegister.ax=0x4f02;
  int32(0x10,&vberegister);
  
  
  *resolution_ptr=1280;
}
void init_vga(){
  regs16_t vgaregister;
  vgaregister.ax=0x0013;
  int32(0x10,&vgaregister);
  *resolution_ptr=320;
}

void kernel_main(void) 
{
  PIC_remap (20, 28);
  resolution_ptr=(int*)0x2ff0;
  c_sti();
  init_vbe ();
    printstring("Kernel sucessfully loaded.");
  newline();
  printstring("newline test.");
  newline();
  printfont ("testing font");

}

