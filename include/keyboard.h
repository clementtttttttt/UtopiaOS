#define TRUE 1
#define CHECK_BIT(var,pos) (((var)>>(pos)) & 1)

#define CHECK_BIT0(var,pos) (((var)>>(pos)) & 0)
void printstring(unsigned char *d);
void newline();

void outb( unsigned short port, unsigned char val )
{
   asm volatile("out %0, %1" : : "a"(val), "Nd"(port) );
}

 unsigned char inb (unsigned short int port)
{
  unsigned char v;

  __asm__ __volatile__ ("inb %w1,%0":"=r" (v):"Nd" (port));
  return v;
}

static inline void io_wait(void)
{
    /* TODO: This is probably fragile. */
    asm volatile ( "jmp 1f\n\t"
                   "1:jmp 2f\n\t"
                   "2:" );
}

void waitforkey(){
    printstring("Waiting for the keyboard controller...");
    while(TRUE){
        
        if(CHECK_BIT(inb(0x64),1)==0){
            printstring("OK");
            newline();
            return;
        }
       
    }
}
void waitforkeyout(){
    newline();
    printstring("Waiting for keyboard controller to output...");
    while(TRUE){
        
        if(CHECK_BIT0(inb(0x64),0)==0){
            printstring("OK");
            newline();
            return;
        }
       
    }

}
void out2keyboard(unsigned char value){
        waitforkey();

    outb(0x64,0xd2);
    waitforkeyout();
    outb(0x60,value);
}
char temp;
void hang();
void initkeyboard(){
    newline();
    printstring("Enabling A20 just incase...");
    waitforkeyout();
    outb(0x64,0xD0);
    waitforkeyout();
    temp=inb(0x60);
    temp |= 1 << 1;
    waitforkey();
    outb(0x64,0xD1);
    waitforkeyout();
    outb(0x60,temp);
    printstring("A20 enabled.");
    newline();
    printstring("[PS/2 INIT ROUTINE]");
    newline();
    newline();
    waitforkey();


    outb(0x64,0xaa);
    waitforkeyout();
            printstring("Testing PS/2 controller...");

    if(inb(0x64)==0x5C){
        printstring("FAIL");
        newline();
        printstring("FATAL ERROR: PS/2 controller test failed");
        hang();
    }
    else printstring("OK");
    newline();
    printstring("Detecting PS/2 Port #1 device type...");
    newline();
    out2keyboard(0xf5);
}

          
