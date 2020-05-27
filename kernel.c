#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include "include/rmode.h"
#include "include/graphics.h"
#include "include/font.h"
#include "include/asmfunc.h"
 
void init_vga(){
    regs16_t vgaregister;
  vgaregister.ax=0x0013;
  int32(0x10,&vgaregister);
}


void kernel_main(void) 
{
  init_vga();

  printstring(0xc);
  printstring("utopiaos version alpha");
}
 asm(".section .rodata");
