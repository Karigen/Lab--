assume cs:code, ds:data, ss:stack1

data segment
    
 var1 db 92h, 95h, 12h, 71h, 08h, 27h, 92h, 0c3h ;变量 var1 保存长度为 8 个字节的有符号数1
 var2 db 8eh, 3dh, 0c2h, 0abh,7ah, 35h, 0a5h, 09h ;变量 var2 保存长度为 8 个字节的有符号数2
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
    mov cx, len ;长补码长8字节，定义外层循环次数8 
    mov si, 0
    clc ;CF置零 
    
    loop1:
        mov al, ds:var1[si]
        push ax
        mov bl, ds:var2[si]
        push bx
        call addL   ;调用相加函数
        inc si
        loop loop1
    
    mov ax, 4c00h
    int 21h                                
    
    addL proc
        ;我觉着也没有需要现场保护的东西
        
        mov bp, sp              
        mov bl, ss:[bp+2]   ;var2，虽然这两个寄存器的值压根就没变，但也算是堆栈传参了
        mov al, ss:[bp+4]   ;var1
        adc al, bl  ;adc命令，加上CF进位
        mov ds:sum[si], al     
        
        ret 4   ;去除无用数据
                 
    addL endp
    
ends

end start