assume cs:code, ds:data, ss:stack1

data segment
    
 var1 db 92h, 95h, 12h, 71h, 08h, 27h, 92h, 0c3h ;变量 var1 保存长度为 8 个字节的有符号数1
 var2 db 8eh, 3dh, 0c2h, 0abh,7ah, 35h, 0a5h, 09h ;变量 var2 保存长度为 8 个字节的有符号数 2
 len equ $-var2 ;len 计算每个加数所占字节数，len 不占用内存
 sum db len dup(0) ;用于保存运算结果
 
data ends

stack1 segment stack ;子程序设计必须定义堆栈段
    
 dw 40 dup(0)
 
stack1 ends

code segment
start:

    mov ax, data
    mov ds, ax
    mov ax, stack1
    mov ss, ax   
    mov cx,len 
    mov si,0 
    
    clc    ;将cf置0
    lop:
        mov al, sum[si]
        push ax 
        mov al, var1[si]
        push ax
        mov al, var2[si]
        push ax
        call addL   ;调用相加函数
        inc si
        loop lop
    
    mov ax, 4c00h
    int 21h                                
    
    addL proc
        push ax
        push cx
        
        mov bp, sp              
        mov al, [bp+6] ;var1    必须放在低八位
        mov bl, [bp+8] ;var2
        adc al, bl
        mov sum[si], al
        
        pop cx
        pop ax      
        
        ret 6
    addL endp
    
ends

end start