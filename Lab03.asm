assume cs:code, ds:data

data segment
    arry1 dw 223,4037,5635,8226,11542,14430,45257,811
    len equ $-arry1
    res1 db len/2 dup(0)
data ends

code segment
start:
    mov ax, data              
    mov ds, ax
    mov cx, 8   ;��������8������ 
    mov si, 0
    mov di, 0
                                                                                          
    loop1: 
        mov bx, 16  ;һ����16λ
        
        loop2: 
            shl ds:arry1[si], 1 ;����
                  
            jc bj                ;cf==1��������,����      
            inc ds:res1[di]     ;cf==0������������ 
                                                 
            bj: 
            dec bx ;��bx==0ʱ�������ڲ�ѭ��                
            jnz loop2  
            
            
        add si, 2   ;arry1����һ������   
        add di, 1   ;res1����һ�����
                            
        loop loop1
                         
    mov ax, 4c00h                      
    int 21h
        
code ends

end start 
