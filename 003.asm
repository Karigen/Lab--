assume cs:code, ds:data, ss:stack1

data segment
    
 var1 db 92h, 95h, 12h, 71h, 08h, 27h, 92h, 0c3h ;���� var1 ���泤��Ϊ 8 ���ֽڵ��з�����1
 var2 db 8eh, 3dh, 0c2h, 0abh,7ah, 35h, 0a5h, 09h ;���� var2 ���泤��Ϊ 8 ���ֽڵ��з����� 2
 len equ $-var2 ;len ����ÿ��������ռ�ֽ�����len ��ռ���ڴ�
 sum db len dup(0) ;���ڱ���������
 
data ends

stack1 segment stack ;�ӳ�����Ʊ��붨���ջ��
    
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
    
    clc    ;��cf��0
    lop:
        mov al, sum[si]
        push ax 
        mov al, var1[si]
        push ax
        mov al, var2[si]
        push ax
        call addL   ;������Ӻ���
        inc si
        loop lop
    
    mov ax, 4c00h
    int 21h                                
    
    addL proc
        push ax
        push cx
        
        mov bp, sp              
        mov al, [bp+6] ;var1    ������ڵͰ�λ
        mov bl, [bp+8] ;var2
        adc al, bl
        mov sum[si], al
        
        pop cx
        pop ax      
        
        ret 6
    addL endp
    
ends

end start