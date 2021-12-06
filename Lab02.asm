assume cs:codesg, ds:data, es:table 

data segment
    
    db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
    db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
    db '1993','1994','1995'
    ;以上是表示 21 年的 21 个字符串
    dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140317,197514
    dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
    ;以上表示 21 年公司总收入的 21 个 dword 型数据
    dw 3,7,10,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
    dw 11542,14430,15257,17800
    ;以上是表示 21 年公司雇员人数的 21 个 word 型数据

data ends

table segment
                                    
    db 21 dup ('year summ ne ?? ')
    
table ends

code segment
    
start:  

        mov ax,data ;将data数据段的地址存入ds寄存器
        mov ds,ax
        
        mov ax,table    ;将table数据段的地址放入es寄存器
        mov es,ax
        
        mov si,0        ;si寄存器放入data段所需存入的偏移地址        
        
        
        mov cx,21       ;设置循环次数
        mov bx,0000h        ;表示表格的哪一层
        
        l1: ;存入表格的年份列
        
            mov ax,ds:[si]                
            mov es:[bx],ax
            add si,2
            
            mov ax,ds:[si]
            mov es:[bx+2],ax
            add si,2
            
            mov al,' '
            mov es:[bx+4],al    ;填入所有的空格列
            mov es:[bx+9],al
            mov es:[bx+0ch],al
            mov es:[bx+0fh],al
            
            add bx,10h
            
            loop l1
        
        mov cx,21   ;重设循环次数  
        mov bx,0000h;重设层数
        
        l2: ;存入表格的收入列
        
            mov ax,ds:[si]  
            mov es:[bx+5],ax
            add si,2
            
            mov ax,ds:[si]
            mov es:[bx+7],ax
            add si,2

            add bx,10h
            
            loop l2
        
        mov cx,21   ;重设循环次数
        mov bx,0000h;重设层数
            
        l3: ;存入表格的雇员数列
        
            mov ax,ds:[si]  
            mov es:[bx+0ah],ax
            add si,2
            
            add bx,10h
            
            loop l3
            
        mov cx,21   ;重设循环次数
        mov bx,0000h;重设层数           

        l4: ;存入表格的人均收入列
         
            mov ax,es:[bx+5]    
            mov dx,es:[bx+7]
            
            div word ptr es:[bx+0ah]
            
            mov es:[bx+0dh],ax

            add bx,10h
            
            loop l4
        
        mov ax,4c00h    ;退出程序
        int 21h
        
code ends

end start