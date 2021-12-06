assume cs:code, ds:data

data segment
    
    ;我称之为以空间换时间-全相关联映射(伪)-RAID 0.025
    
    ;读入键盘码乘2所对应的内存单元存入其对应频率,esc特判,中断码或者其他键全是0000
    dw 16 dup(0)
    
    ;高音
    ;10h-16h 20h-2ch
    dw 524,587,659,698,784,880,988
    ;20c
    
    dw 7 dup(0)
    
    ;中音
    ;1eh-24h 3ch-48h 
    dw 262,294,330,349,392,440,494
    ;106
    
    dw 7 dup(0)
    
    ;低音
    ;2ch-32h 58h-64h
    dw 131,147,165,175,196,220,247
    
    ;后面不知为何有其他码所以就多搞几个0,一个代码段64KB,我才用了1KNB,我决择是值得的
    dw 500 dup(0)
     
data ends

code segment
    
start:
    mov ax, data
    mov ds, ax
    
    ;初始化定时器8254的2号定时器的控制寄存器 
    mov al, 0b6h
    out 43h, al
    
    lop:    ;鉴于loop有用的代码总共只有14行,我称之为14行诗        
        mov si, 0;用于寻址
        mov ax, 0;重置ax
        mov bx, 0
        
        ;读入键盘码
        in al, 60h
        
        ;没读入直接回去
        cmp ax, 0
        je lop  
    
        ;按下esc,程序退出,end1为退出部分代码
        cmp al, 01h   
        je end1
        
        ;不是esc键,则run去判断
        mov si, ax
        add si, si
        mov bx, ds:[si]
        
        ;对应频率为0,中断或者其他键的键入,对应频率不为0,发声
        cmp bx, 0
        je off
        jne on
        
    on: 
        ;计算
        mov ax, 2870H
        mov dx, 12h
        div word ptr ds:[si]
        
        ;传送频率计算结果
        out 42h, al
        mov al, ah
        out 42h, al
        
        ;开启扬声器
        or al, 00000011B
        out 61h, al
        jmp lop     
        
    off:    ;关闭扬声器
        and al, 11111100B
        out 61h, al
        jmp lop     
         
    end1:        
        mov ax, 4c00h
        int 21h
            
code ends

end start