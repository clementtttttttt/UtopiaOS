global asm_out

;extern void asm_out(char io_port,char io_data)
asm_out:
MOV DX,[ESP+4]
MOV EAX,[ESP+8]
OUT DX,EAX
