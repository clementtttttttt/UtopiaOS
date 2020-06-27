#include <multiboot.h>
multiboot_info_t* public_mbd;
#include <stdint.h>
#include "include/font.h"

void kernel_main(multiboot_info_t* mbd,unsigned int magic){
    public_mbd=mbd;
}
