assume cs:code, ds:data, ss:stack1

data segment
    
 var1 db 92h, 95h, 12h, 71h, 08h, 27h, 92h, 0c3h ;���� var1 ���泤��Ϊ 8 ���ֽڵ��з�����1
 var2 db 8eh, 3dh, 0c2h, 0abh,7ah, 35h, 0a5h, 09h ;���� var2 ���泤��Ϊ 8 ���ֽڵ��з�����2
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
    mov cx, len ;�����볤8�ֽڣ��������ѭ������8 
    mov si, 0
    clc ;CF���� 
    
    loop1:
        mov al, ds:var1[si]
        push ax
        mov bl, ds:var2[si]
        push bx
        call addL   ;������Ӻ���
        inc si
        loop loop1
    
    mov ax, 4c00h
    int 21h                                
    
    addL proc
        ;�Ҿ���Ҳû����Ҫ�ֳ������Ķ���
        
        mov bp, sp              
        mov bl, ss:[bp+2]   ;var2����Ȼ�������Ĵ�����ֵѹ����û�䣬��Ҳ���Ƕ�ջ������
        mov al, ss:[bp+4]   ;var1
        adc al, bl  ;adc�������CF��λ
        mov ds:sum[si], al     
        
        ret 4   ;ȥ����������
                 
    addL endp
    
ends

end start