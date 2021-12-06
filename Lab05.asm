assume cs:code, ds:data

data segment
    
    maxlen db 15    ;0AH子功能入口参数，指定最大字符数
    inputlen db 0   ;0AH子功能出口参数，返回实际输入的字符数
    str1 db 15 dup(0)   ;0AH子功能的字符串缓存区
    str2 db 15 dup(0)   ;09H子功能的字符串缓存区
    
data ends

code segment 
    
start:
    mov ax, data 
    mov ds, ax
    
    lea dx, maxlen
    mov ah, 0ah
    int 21h ;用户输入字符串
    
    mov cl, inputlen    ;实际输入的字符数--循环次数
    mov si, 0   
    mov di, 0

    loop1: 
        cmp str1[si], 30h   ;小于30h 则跳转到store将字符缓存下来
        jb store    
        
        cmp str1[si], 39h   ;大于39h 则跳转到store将字符缓存下来
        ja store
             
        jmp next    ;大于30h小于39h，即数字，跳过存储
  
        store:  ;存储
            mov al, str1[si]  
            mov str2[di], al 
            inc di 
 
        next:   ;跳到输入的下一个字符，继续执行 
            inc si
    
    loop loop1 
     
    ;将字符输出    
    mov str2[di], '$'   ;放结尾
 
    mov dl, 0dh  ;回车
    mov ah, 02h   
    int 21h
    
    mov dl, 0ah  ;换行
    mov ah, 02h
    int 21h 
    
    lea dx, str2    ;输出操作后的字符串
    mov ah, 09h
    int 21h 
      
    mov ax, 4c00h
    int 21h
        
ends
 
end start