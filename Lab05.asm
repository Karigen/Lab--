assume cs:code, ds:data

data segment
    
    maxlen db 15    ;0AH�ӹ�����ڲ�����ָ������ַ���
    inputlen db 0   ;0AH�ӹ��ܳ��ڲ���������ʵ��������ַ���
    str1 db 15 dup(0)   ;0AH�ӹ��ܵ��ַ���������
    str2 db 15 dup(0)   ;09H�ӹ��ܵ��ַ���������
    
data ends

code segment 
    
start:
    mov ax, data 
    mov ds, ax
    
    lea dx, maxlen
    mov ah, 0ah
    int 21h ;�û������ַ���
    
    mov cl, inputlen    ;ʵ��������ַ���--ѭ������
    mov si, 0   
    mov di, 0

    loop1: 
        cmp str1[si], 30h   ;С��30h ����ת��store���ַ���������
        jb store    
        
        cmp str1[si], 39h   ;����39h ����ת��store���ַ���������
        ja store
             
        jmp next    ;����30hС��39h�������֣������洢
  
        store:  ;�洢
            mov al, str1[si]  
            mov str2[di], al 
            inc di 
 
        next:   ;�����������һ���ַ�������ִ�� 
            inc si
    
    loop loop1 
     
    ;���ַ����    
    mov str2[di], '$'   ;�Ž�β
 
    mov dl, 0dh  ;�س�
    mov ah, 02h   
    int 21h
    
    mov dl, 0ah  ;����
    mov ah, 02h
    int 21h 
    
    lea dx, str2    ;�����������ַ���
    mov ah, 09h
    int 21h 
      
    mov ax, 4c00h
    int 21h
        
ends
 
end start