int x=0;
int y=0;
char screenchars[1000];
char screencounter;
void putfont(char *e){
    int i;
    char *z,s;
    for(i=0;i<10;i++){
        z=0xa0000+(y+i)*320+x;
        s=e[i];
        
		if ((s & 0x80) != 0) { z[0] = 15; }
		if ((s & 0x40) != 0) { z[1] = 15; }
		if ((s & 0x20) != 0) { z[2] = 15; }
		if ((s & 0x10) != 0) { z[3] = 15; }
		if ((s & 0x08) != 0) { z[4] = 15; }
		if ((s & 0x04) != 0) { z[5] = 15; }
		if ((s & 0x02) != 0) { z[6] = 15; }
		if ((s & 0x01) != 0) { z[7] = 15; }
    }
}
void printstring(unsigned char *d){
        extern char font[4096];
        for(;*d!=0x00;d++){
            if(x==320){
                y+=10;
            }
            if(*d==0x8){
                x-=8;
                screencounter-=1;
                putfont(font+0x0*16);
            }
            
            putfont(font+*d*16);
                               x+=8;
            
            
        }

return;        
}
void newline(){
    x=0;
    y+=10;
}
    
