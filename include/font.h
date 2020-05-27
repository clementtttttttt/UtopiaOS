 /* font name: utopia,if you want it just use it i dont care*/
 char sysfont_a[8][8]={
    ".0000...",
    "0....0..",
    "0....0..",
    "000000..",
    "0....0..",
    "0....0..",
    "0....0..",
    "0....0.."};

char sysfont_b[8][8]={
    "00000...",
    "0....0..",
    "0....0..",
    "00000...",
    "0....0..",
    "0....0..",
    "0....0..",
    "00000..."};
char sysfont_c[8][8]={
    ".00000..",
    "0.......",
    "0.......",
    "0.......",
    "0.......",
    "0.......",
    "0.......",
    ".00000.."};
char sysfont_d[8][8]={
    "00000...",
    "0....0..",
    "0....0..",
    "0....0..",
    "0....0..",
    "0....0..",
    "0....0..",
    "00000..."};
char sysfont_e[8][8]={
    "000000..",
    "0.......",
    "0.......",
    "000000..",
    "0.......",
    "0.......",
    "0.......",
    "000000.."}; 
char sysfont_f[8][8]={
    "000000..",
    "0.......",
    "0.......",
    "000000..",
    "0.......",
    "0.......",
    "0.......",
    "0......."};
char sysfont_g[8][8]={
    ".00000..",
    "0.......",
    "0.......",
    "0...00..",
    "0....0..",
    "0....0..",
    "0....0..",
    ".0000..."};
char sysfont_h[8][8]={
    "0....0..",
    "0....0..",
    "0....0..",
    "000000..",
    "0....0..",
    "0....0..",
    "0....0..",
    "0....0.."};
char sysfont_i[8][8]={
    ".00000..",
    "...0....",
    "...0....",
    "...0....",
    "...0....",
    "...0....",
    "...0....",
    ".00000.."};
char sysfont_j[8][8]={
    "0000000.",
    "...0....",
    "...0....",
    "...0....",
    "0..0....",
    "0..0....",
    "0..0....",
    ".00....."};
char sysfont_k[8][8]={
    "0....0..",
    "0...0...",
    "0..0....",
    "0.0.....",
    "000.....",
    "0..0....",
    "0...0...",
    "0....0.."};
char sysfont_l[8][8]={
    "0.......",
    "0.......",
    "0.......",
    "0.......",
    "0.......",
    "0.......",
    "0.......",
    "000000.."};
char sysfont_m[8][8]={
    "0....0..",
    "00..00..",
    "0.00.0..",
    "0....0..",
    "0....0..",
    "0....0..",
    "0....0..",
    "0....0.."
    
};
char sysfont_n[8][8]={
    "0....0..",
    "00...0..",
    "0.0..0..",
    "0..0.0..",
    "0...00..",
    "0....0..",
    "0....0..",
    "0....0.."};
char sysfont_o[8][8]={
    "..00....",
    ".0..0...",
    "0....0..",
    "0....0..",
    "0....0..",
    "0....0..",
    ".0..0...",
    "..00...."};
char sysfont_p[8][8]={
    "0000....",
    "0...0...",
    "0....0..",
    "0...0...",
    "0000....",
    "0.......",
    "0.......",
    "0......."};
char sysfont_q[8][8]={
    ".0000...",
    "0....0..",
    "0....0..",
    "0....0..",
    "0....0..",
    "0....0..",
    "0....0..",
    ".0000.0."};
char sysfont_r[8][8]={
    "00000...",
    "0....0..",
    "0....0..",
    "00000...",
    "0.0.....",
    "0..0....",
    "0...0...",
    "0....0.."};
char sysfont_s[8][8]={
    ".00000..",
    "0.......",
    "0.......",
    ".0000...",
    ".....0..",
    ".....0..",
    ".....0..",
    "00000..."};
char sysfont_t[8][8]={
    "0000000.",
    "...0....",
    "...0....",
    "...0....",
    "...0....",
    "...0....",
    "...0....",
    "...0...."};
char sysfont_u[8][8]={
    "0....0..",
    "0....0..",
    "0....0..",
    "0....0..",
    "0....0..",
    "0....0..",
    "0....0..",
    ".0000..."};
char sysfont_v[8][8]={
    "0....0..",
    "0....0..",
    ".0..0...",
    ".0..0...",
    ".0..0...",
    "..00....",
    "..00....",
    "..00...."};
char sysfont_w[8][8]={
    "0..0..0.",
    "0..0..0.",
    "0..0..0.",
    "0..0..0.",
    "0..0..0.",
    "0..0..0.",
    "0.0.0.0.",
    ".0...0.."};
char sysfont_x[8][8]={
    "0....0..",
    "0....0..",
    ".0..0...",
    "..00....",
    ".0..0...",
    "0....0..",
    "0....0..",
    "0....0.."};
char sysfont_y[8][8]={
    "0....0..",
    "0....0..",
    ".0..0...",
    "..00....",
    "..00....",
    "..00....",
    "..00....",
    "..00...."};
char sysfont_z[8][8]={
    "000000..",
    "....0...",
    "....0...",
    "...0....",
    "...0....",
    "..0.....",
    ".0......",
    "000000.."};
int offsetx=0;
int offsety=0;
void printstring(unsigned char *s){
    for(; *s!=0x00;s++){
        if(*s=='a'){
            drawtile(sysfont_a,15,offsetx,offsety);
            offsetx=offsetx+8;
        }
         if(*s=='b'){
            drawtile(sysfont_b,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='c'){
            drawtile(sysfont_c,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='d'){
            drawtile(sysfont_d,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='e'){
            drawtile(sysfont_e,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='f'){
            drawtile(sysfont_f,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='g'){
            drawtile(sysfont_g,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='h'){
            drawtile(sysfont_h,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='i'){
            drawtile(sysfont_i,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='j'){
            drawtile(sysfont_j,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='k'){
            drawtile(sysfont_k,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='l'){
            drawtile(sysfont_l,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='m'){
            drawtile(sysfont_m,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='n'){
            drawtile(sysfont_n,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='o'){
            drawtile(sysfont_o,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='p'){
            drawtile(sysfont_p,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='q'){
            drawtile(sysfont_q,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='r'){
            drawtile(sysfont_r,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='s'){
            drawtile(sysfont_s,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='t'){
            drawtile(sysfont_t,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='u'){
            drawtile(sysfont_u,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='v'){
            drawtile(sysfont_v,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='w'){
            drawtile(sysfont_w,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='x'){
            drawtile(sysfont_x,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='y'){
            drawtile(sysfont_y,15,offsetx,offsety);
            offsetx=offsetx+8;
        } if(*s=='z'){
            drawtile(sysfont_z,15,offsetx,offsety);
            offsetx=offsetx+8;
        }
    }
}
