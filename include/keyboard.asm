 
global keyboarddetect

keyboarddetect:
    MOV AL,0XEE
    OUT 0X64,AL
    IN AL,0X60
    CMP AL,0XEE
    je detected
    MOV EAX,0
    RET
    
    
detected:
    MOV EAX,1
    RET
