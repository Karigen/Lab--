assume cs:code,ds:data
data segment     
   
    hz dw 131,147,165,175,196,220,247,262,294,330,349,392,440,494,524,587,659,698,784,880,988
    break db 0ach,0adh,0aeh,0afh,0b0h,0b1h,0b2h,9eh,9fh,0a0h,0a1h,0a2h,0a3h,0a4h,90h,91h,92h,93h,94h,95h,96h
    mark db 2ch,2dh,2eh,2fh,30h,31h,32h,1eh,1fh,20h,21h,22h,23h,24h,10h,11h,12h,13h,14h,15h,16h   
   
    len equ $-mark     
    
data ends
code segment
    start:
    mov ax, data
    mov ds, ax
    
        
    ;�����ַ�     
 
    INPUT:
    mov ah,01h
    int 21h
    mov cx, 0h   
    mov si,cx    
    in al, 60h
    lop:
     
       cmp al, ds:break[si]  
        je playoff   
         
     
        cmp al, ds:mark[si]           
        je playon      
     
        cmp al,01H
        je exit     ;�ж��Ƿ���esc�������������˳�����
       
        cmp si,len   ;��ȫ���Ƚ�֮��Ҳû��ƥ�������������
        je INPUT

        add si,1 
        
    loop lop
 
    
    
    playon:

   mov bx,si
   add bx,bx
    ;����Ƶ��
    mov dx,0012H
    mov ax,2870H
    div ds:hz[bx]
    mov bx,ax
    ;�����42H�˿�  
    mov al,0b6h
    out 43h,al
    mov ax,bx
    out 42H,al
    mov al,ah
    out 42h,al    
    
      ;��������
    in al ,61h                             
    or al,00000011B
    OUT 61h, al     
    
    jmp INPUT
 
   playoff:
 
    ;�ر�������
    in al,61h
    and al, 11111100B
    out 61h,al                   
 
    jmp INPUT
     
   
 
    exit:        
 
    mov ah,4ch
    int 21h
    

code ends
 
end start