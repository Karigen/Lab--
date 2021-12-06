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
    mov cx, 8   ;数组里面8个数据 
    mov si, 0
    mov di, 0
                                                                                          
    loop1: 
        mov bx, 16  ;一个字16位
        
        loop2: 
            shl ds:arry1[si], 1 ;左移
                  
            jc bj                ;cf==1，不计数,跳过      
            inc ds:res1[di]     ;cf==0，计数器自增 
                                                 
            bj: 
            dec bx ;当bx==0时，跳出内层循环                
            jnz loop2  
            
            
        add si, 2   ;arry1的下一个数据   
        add di, 1   ;res1的下一个结果
                            
        loop loop1
                         
    mov ax, 4c00h                      
    int 21h
        
code ends

end start 
