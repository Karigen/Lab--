assume cs:codesg, ds:data, es:table 

data segment
    
    db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
    db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
    db '1993','1994','1995'
    ;�����Ǳ�ʾ 21 ��� 21 ���ַ���
    dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140317,197514
    dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
    ;���ϱ�ʾ 21 �깫˾������� 21 �� dword ������
    dw 3,7,10,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
    dw 11542,14430,15257,17800
    ;�����Ǳ�ʾ 21 �깫˾��Ա������ 21 �� word ������

data ends

table segment
                                    
    db 21 dup ('year summ ne ?? ')
    
table ends

code segment
    
start:  

        mov ax,data ;��data���ݶεĵ�ַ����ds�Ĵ���
        mov ds,ax
        
        mov ax,table    ;��table���ݶεĵ�ַ����es�Ĵ���
        mov es,ax
        
        mov si,0        ;si�Ĵ�������data����������ƫ�Ƶ�ַ        
        
        
        mov cx,21       ;����ѭ������
        mov bx,0000h        ;��ʾ������һ��
        
        l1: ;������������
        
            mov ax,ds:[si]                
            mov es:[bx],ax
            add si,2
            
            mov ax,ds:[si]
            mov es:[bx+2],ax
            add si,2
            
            mov al,' '
            mov es:[bx+4],al    ;�������еĿո���
            mov es:[bx+9],al
            mov es:[bx+0ch],al
            mov es:[bx+0fh],al
            
            add bx,10h
            
            loop l1
        
        mov cx,21   ;����ѭ������  
        mov bx,0000h;�������
        
        l2: ;�������������
        
            mov ax,ds:[si]  
            mov es:[bx+5],ax
            add si,2
            
            mov ax,ds:[si]
            mov es:[bx+7],ax
            add si,2

            add bx,10h
            
            loop l2
        
        mov cx,21   ;����ѭ������
        mov bx,0000h;�������
            
        l3: ;������Ĺ�Ա����
        
            mov ax,ds:[si]  
            mov es:[bx+0ah],ax
            add si,2
            
            add bx,10h
            
            loop l3
            
        mov cx,21   ;����ѭ������
        mov bx,0000h;�������           

        l4: ;��������˾�������
         
            mov ax,es:[bx+5]    
            mov dx,es:[bx+7]
            
            div word ptr es:[bx+0ah]
            
            mov es:[bx+0dh],ax

            add bx,10h
            
            loop l4
        
        mov ax,4c00h    ;�˳�����
        int 21h
        
code ends

end start