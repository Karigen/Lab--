assume cs:code, ds:data

data segment
    
    ;�ҳ�֮Ϊ�Կռ任ʱ��-ȫ�����ӳ��(α)-RAID 0.025
    
    ;����������2����Ӧ���ڴ浥Ԫ�������ӦƵ��,esc����,�ж������������ȫ��0000
    dw 16 dup(0)
    
    ;����
    ;10h-16h 20h-2ch
    dw 524,587,659,698,784,880,988
    ;20c
    
    dw 7 dup(0)
    
    ;����
    ;1eh-24h 3ch-48h 
    dw 262,294,330,349,392,440,494
    ;106
    
    dw 7 dup(0)
    
    ;����
    ;2ch-32h 58h-64h
    dw 131,147,165,175,196,220,247
    
    ;���治֪Ϊ�������������ԾͶ�㼸��0,һ�������64KB,�Ҳ�����1KNB,�Ҿ�����ֵ�õ�
    dw 500 dup(0)
     
data ends

code segment
    
start:
    mov ax, data
    mov ds, ax
    
    ;��ʼ����ʱ��8254��2�Ŷ�ʱ���Ŀ��ƼĴ��� 
    mov al, 0b6h
    out 43h, al
    
    lop:    ;����loop���õĴ����ܹ�ֻ��14��,�ҳ�֮Ϊ14��ʫ        
        mov si, 0;����Ѱַ
        mov ax, 0;����ax
        mov bx, 0
        
        ;���������
        in al, 60h
        
        ;û����ֱ�ӻ�ȥ
        cmp ax, 0
        je lop  
    
        ;����esc,�����˳�,end1Ϊ�˳����ִ���
        cmp al, 01h   
        je end1
        
        ;����esc��,��runȥ�ж�
        mov si, ax
        add si, si
        mov bx, ds:[si]
        
        ;��ӦƵ��Ϊ0,�жϻ����������ļ���,��ӦƵ�ʲ�Ϊ0,����
        cmp bx, 0
        je off
        jne on
        
    on: 
        ;����
        mov ax, 2870H
        mov dx, 12h
        div word ptr ds:[si]
        
        ;����Ƶ�ʼ�����
        out 42h, al
        mov al, ah
        out 42h, al
        
        ;����������
        or al, 00000011B
        out 61h, al
        jmp lop     
        
    off:    ;�ر�������
        and al, 11111100B
        out 61h, al
        jmp lop     
         
    end1:        
        mov ax, 4c00h
        int 21h
            
code ends

end start