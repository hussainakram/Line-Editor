                     
;            ***************************************
;           ! %%%%%                           %%%%% !
;           ! Muzamil bashir 2014-CS-03       %%%%% !
;           ! Husain Akram   2010-CS-02       %%%%% !
;           ! Noman Shaid    2014-CS-19       %%%%% !
;           ! %%%%% ASSEMBLY LANGUAGE PROJECT %%%%% !
;           ! %%%%%       "LINE EDITOR"       %%%%% !
;           ! %%%%%                           %%%%% !
;           ! %%%%%                           %%%%% !
;            ***************************************

 
 Title Line editor
 
.model small
.stack 100h
.data
  set_cursor dw 000      ; set cursor set_cursorition 
  last_key db 000        ; last_keyvious input key
  next_key db 000        ;current input key
  color db 0fh           ; color variable 
  flag db ?              ; flag 
  p db ?                 ; page
  msg00 db  "%%%%%%%%%%%Muzamil bashir        ***** $"
  msg01 db  ""
  msg02 db "*****         2010-CS-03          ***** $"
  msg03 db "*****  ASSEMBLY LANGUAGE PROJECT  ***** $"
  msg04 db "*****        LINE EDITOR          ***** $"  
  msg05 db "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% $"
  msg06 db "PRESS DESIRED KEY TO GO TO RESPECTIVE MODE:$"
  msg07 db "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$"
  msg08 db "% L (DRAW LINE)   D (DELETE LINE)   C (COLOR CHANGE) %$"
  msg09 db "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$"
  msg10 db "COLOR OPTIONS:$"
  msg11 db "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$"
  msg12 db "% 1 (BLUE)        2 (GREEN)         3 (CYAN) %$"
  msg13 db "%                                            %$"
  msg14 db "% 4 (RED)         5 (MAGENTA)       6 (BROWN)%$"
  msg15 db "%                                            %$"
  msg16 db "%                 7 (WHITE)                  %$"
  msg17 db "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$"

     
.code
 jmp manual
 main proc 
  
     mov dh,20
     mov dl,15
     mov ah,02
     int 10h 
     mov ax,@data
     mov ds,ax
              
     mov set_cursor,dx    ; save cursor set_cursor position 
     mov bh,0             ; initially at page 0
    
    
;********    
 manual:
;********    
     mov dh,2
     mov dl,20 
     mov ah,02
     int 10h        
     lea dx,msg00         ;msg00
     mov ah,9
     int 21h
;-----------------------------------------------------------------
     mov dh,3
     mov dl,20 
     mov ah,02
     int 10h
     lea dx,msg01         ;msg01
     mov ah,9
     int 21h
;-----------------------------------------------------------------    
     mov dh,4
     mov dl,20 
     mov ah,02
     int 10h
     lea dx,msg02         ;msg02
     mov ah,9
     int 21h
;-----------------------------------------------------------------     
     mov dh,5
     mov dl,20 
     mov ah,02
     int 10h               
     lea dx,msg03         ;msg03
     mov ah,9
     int 21h
;-----------------------------------------------------------------  
     mov dh,6
     mov dl,20
     mov ah,02
     int 10h
     lea dx,msg04           ;msg04
     mov ah,9
     int 21h
;-----------------------------------------------------------------
     mov dh,7
     mov dl,20 
     mov ah,02
     int 10h
     lea dx,msg05           ;msg05
     mov ah,9
     int 21h
;----------------------------------------------------------------- 
     mov dh,10
     mov dl,5 
     mov ah,02
     int 10h
     lea dx,msg06           ;msg06
     mov ah,9
     int 21h
;-----------------------------------------------------------------  
     mov dh,11
     mov dl,5 
     mov ah,02
     int 10h 
     lea dx,msg07           ;msg07
     mov ah,9
     int 21h  
;----------------------------------------------------------------- 
     mov dh,12
     mov dl,5 
     mov ah,02
     int 10h
     lea dx,msg08           ;msg08
     mov ah,9
     int 21h
;-----------------------------------------------------------------
     mov dh,13
     mov dl,5 
     mov ah,02
     int 10h
     lea dx,msg09           ;msg09
     mov ah,9
     int 21h  
;-----------------------------------------------------------------
     mov dh,16
     mov dl,5 
     mov ah,02
     int 10h 
     lea dx,msg10           ;msg10
     mov ah,9
     int 21h  
;-----------------------------------------------------------------
     mov dh,17
     mov dl,5 
     mov ah,02
     int 10h
     lea dx,msg11           ;msg11
     mov ah,9
     int 21h  
;----------------------------------------------------------------- 
     mov dh,18
     mov dl,5 
     mov ah,02
     int 10h
     lea dx,msg12           ;msg12
     mov ah,9
     int 21h  
;-----------------------------------------------------------------
     mov dh,19
     mov dl,5 
     mov ah,02
     int 10h
     lea dx,msg13           ;msg13
     mov ah,9
     int 21h  
;-----------------------------------------------------------------
     mov dh,20
     mov dl,5 
     mov ah,02
     int 10h
     lea dx,msg14           ;msg14
     mov ah,9
     int 21h  
;-----------------------------------------------------------------
     mov dh,21
     mov dl,5 
     mov ah,02
     int 10h
     lea dx,msg15           ;msg15
     mov ah,9
     int 21h        
;-----------------------------------------------------------------
     mov dh,22
     mov dl,5 
     mov ah,02
     int 10h
     lea dx,msg16           ;msg16
     mov ah,9
     int 21h      
;-----------------------------------------------------------------
     mov dh,23
     mov dl,5 
     mov ah,02
     int 10h
     lea dx,msg17           ;msg17
     mov ah,9
     int 21h   
     
     
     
;********                       
  input:         
;********  
   mov p,bh               ; set page
   mov bh,next_key        ; save current key in bh  
   mov last_key,bh        ; for new input last_keyvious key woud                  
                          ;  be remebered by last_key variable
   mov bh,p          
   mov ah,00              ; 0 func, for key input 
   int 16h
   mov next_key,ah        ; store the current input in next_key var

   
; comparisons of input keys with scan codes of various keys 
;----------------------------------------------------------   
   cmp ah,4dh             ; right key  scan code 4dh
   je right
                    
   cmp ah,15h              ;right tilt key scan code 15h  "y"
   je  righttilt
   
   
   cmp ah,4bh             ; left key scan
   je left
   
   cmp ah,14h             ;left tilt scan key 14h       "t"
   je  lefttilt
   
      
      
   cmp ah,22h             ;down tilt scan key     "g"
   ;jmp uptilt
   
   
      
   cmp ah,48h             ; up key scan
   je up
   
   cmp ah,50h             ; down key scan
   je down
   
   cmp ah,20h             ; dlete mode using d key scan
   je Delete
   
   cmp ah,26              ; drw mode using L key scan
   je Draw
              
   cmp ah,2Eh             ; color mode using c key scan
   je colors                               
      
                                    
                                    
                                    
   
;                      %%%%%%%%%%%%%
;                      % DRAW MODE %
;                      %%%%%%%%%%%%%

;*******
  Draw:
;*******
   mov flag,26           ; flag flag is set to key L for draw mode
   jmp input 
   
   
                                 
                                 
;               %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;               % printing toward right side %  
;               %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           
;********
  right:
;********              
   cmp flag,26h          ; ckeck if key is L then draw right 
   je right
   
   cmp flag,20h          ;Delete right 
   je Del_right
   
   cmp last_key,4bh     
   je rightleft          ;if last_keyvious key is left and next is 
                         ;right move then jump to left right label 
   
   cmp last_key,48h
   je upright            ;jump to upright elbow label
   
   cmp last_key,50h
   je downright          ;jump to downright elbow label
   
;print function
;---------------   
   mov ah,9                 ; 09 video function
   mov al,00c4h             ; print - (dash)
   mov bl,color             ; color seting in bl
   mov cx,1                 ; print once
   int 10h

;Set cursor set_cursoriton   
;--------------------------
   mov dx,set_cursor
   inc dl                   ; increment column            
   
   mov ah,2                 ;cursor set_cursorition
   int 10h
   mov set_cursor,dx        ; save cursor set_cursorition
   
   jmp input  
   
  
  
;********
  righttilt:
;********              
   cmp flag,26h          ; ckeck if key is L then draw right 
   je right
   
   cmp flag,20h          ;Delete righttilt 
   je Del_righttilt
   
            
   
;print function
;---------------   
   mov ah,9                 ; 09 video function
   mov al,005Ch             ; print \ (dash)
   mov bl,color             ; color seting in bl
   mov cx,1                 ; print once
   int 10h

;Set cursor set_cursoriton   
;--------------------------
   mov dx,set_cursor
   inc dl                   ; increment column            
   inc dh
    
   mov ah,2                 ;cursor set_cursorition
   int 10h
   mov set_cursor,dx        ; save cursor set_cursorition
   
   jmp input  
   
   
    
               
   
;                   %%%%%%%%%%%%%%%%%
;                   % left printing %
;                   %%%%%%%%%%%%%%%%% 

;******             
 left:
;****** 
   cmp flag,26h
   je  left
   
   cmp flag,20h
   je Del_left
   
   cmp last_key,48h
   je upleft
  
   cmp last_key,50h
   je downleft
  
   cmp last_key,4dh
   je rightleft

; print function 
;-----------------  
   mov ah,9
   mov al,00c4h             ; scan code for a dash
   mov bl,color
   mov cx,1
   int 10h 
   
    mov dx,set_cursor
    dec dl                  ; dec coloumn to move left

; set cursor set_cursorition   
;----------------------------  
   mov ah,2
   int 10h
   mov set_cursor,dx
   
   jmp input    
   


;******             
 lefttilt:
;****** 
   cmp flag,26h
   je  left
   
   cmp flag,20h
   je Del_lefttilt
   
 

; print function 
;-----------------  
   mov ah,9
   mov al,002Fh             ; scan code for a /
   mov bl,color
   mov cx,1
   int 10h 
   
    mov dx,set_cursor
    dec dl 
    inc dh                 ; dec coloumn to move left

; set cursor set_cursorition   
;----------------------------  
   mov ah,2
   int 10h
   mov set_cursor,dx
   
   jmp input    
   
   
   
      
   
   
   
;                 %%%%%%%%%%%%%%%%%%%%%%%%%
;                 % Upward printing Label %
;                 %%%%%%%%%%%%%%%%%%%%%%%%% 
 
;**** 
 up: 
;****   
   cmp flag,26h
   je  up
   cmp flag,20h
   je Del_up
   
   cmp last_key,4dh
   je rightup  
   
   cmp last_key,4bh
   je leftup
   
   cmp last_key,50h
   je  downup
  
; print fuction
;----------------   
   mov ah,9
   mov al,00B3h             ; scan code of up slash
   mov bl,color
   mov cx,1
   int 10h
   mov dx,set_cursor
  
   cmp dh,0                 ;  page change when you reach 0th row   
   je page_change1
  
   dec dh                   ; decremnt row for going up
; set cursor set_cursoriton 
;--------------------------   
   mov ah,2
   int 10h
   mov set_cursor,dx        ; save cursor set_cursoriton 
   
   jmp input        
   
   
   
      
   
   
;                  %%%%%%%%%%%%%%%%%%%%%%
;                  %  Downward printing %
;                  %%%%%%%%%%%%%%%%%%%%%%

;******
 down:
;******
   cmp flag,26h
   je  down 
   cmp flag,20h
   je Del_down
   
   cmp last_key,4dh 
   je rightdown
   
   cmp last_key,4bh
   je leftdown

; print fuction
;--------------   
   mov ah,9
   mov al,00B3h
   mov bl,color
   mov cx,1
   int 10h 
   
   mov dx,set_cursor
   
   cmp dh,24                ; page change when you reach 24th row  
   je page_change
   
    inc dh                  ; increment row
    
;cursor set_cursoriton
;---------------------   
   mov ah,2
   int 10h         
   mov set_cursor,dx        ; save cursor set_cursoriton 
                          
                          
   jmp input   
   
   
   
   
   
   
;       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
;       % printing while moving RIGHT to LEFT  %
;       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

;**********   
 rightleft: 
;**********
   mov ah,9
   mov al,00c4h
   mov bl,0fh
   mov cx,1
   int 10h
   
   jmp input
            
            
   
   
            
           
;        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
;        % printing while moving RIGHT to UP  %
;        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

;********   
 rightup:
;********   
   mov ah,9
   mov al,00d9h             ; right up elbow scan code 
   mov bl,color
   mov cx,1
   int 10h
   
   mov set_cursor,dx
   dec dh
;cursor set_cursorition
;------------------------  
   mov ah,2          
   int 10h
   mov set_cursor,dx        ; save cursor set_cursorition 
   
   jmp input  
   
   
   
   
   
   
;         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
;         % printing while moving DOWN to UP  %
;         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       
;*******
 downup:
;*******
   mov ah,9
   mov al,00b3h
   mov bl,color
   mov cx,1
   int 10h
   
   mov set_cursor,dx
   dec dh

;cursor set_cursorition   
;----------------------   
   mov ah,2          
   int 10h
   mov set_cursor,dx        ; save cursor set_cursoriton 
   
   jmp input    
   
   
   
   
   
;     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;     % printing an elbow while moving Up to LEFT %
;     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
;*******
 upleft:
;*******   
   mov ah,9
   mov al,00bfh
   mov bl,color
   mov cx,1
   int 10h
   
   mov set_cursor,dx
   dec dl
 
;cursor set_cursorition   
;-----------------------   
   mov ah,2         
   int 10h
   mov set_cursor,dx        ; save cursor set_cursorition
   
   jmp input
               
               
   
               
;     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;     % printing an elbow while moving DOWN to RIGHT %
;     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


;*********   
 downright:
;*********   
   mov ah,9
   mov al,00c0h
   mov bl,color
   mov cx,1
   int 10h
   
   mov set_cursor,dx
   inc dl

;cursor set_cursorition   
;-----------------------   
   mov ah,2         
   int 10h
   mov set_cursor,dx        ; save cursor set_cursorition
   
   jmp input
   
   
   
   
     
   
;     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;     % printing an elbow while moving LEFT TO DOWN %
;     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
;********   
 leftdown:
;********   
   mov ah,9
   mov al,00dah
   mov bl,color
   mov cx,1
   int 10h
   
   mov set_cursor,dx
   inc dh                   ; inc row 

;cursor set_cursorition
;-----------------------   
   mov ah,2          
   int 10h
   mov set_cursor,dx        ; save cursor set_cursortion
   
   jmp input             
   
   
   
   
   

;     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;     % printing an elbow while moving RIGHT TO DOWN %
;     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
;***********   
 rightdown:
;***********   
   mov ah,9
   mov al,00bfh
   mov bl,color
   mov cx,1
   int 10h
   
   mov set_cursor,dx
   inc dh
;cursor set_cursorition
;----------------------    
   mov ah,2         
   int 10h
   mov set_cursor,dx        ; save cursor set_cursoriton 
   
   jmp input
              
              
   
   
              
              
;     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;     % printing an elbow while moving LEFT to UP %
;     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
;*********   
  leftup:
;*********   
   mov ah,9
   mov al,00c0h
   mov bl,color
   mov cx,1
   int 10h
   
   mov set_cursor,dx
   dec dh      ; dec row 
   
; cursor set_cursorition
;------------------------   
   mov ah,2         
   int 10h
   mov set_cursor,dx        ; save cursor set_cursorition
   
   jmp input

                        

   
                        
                        
;     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;     % printing an elbow while moving Up to RIGHT%
;     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
;*********   
  upright:
;*********              
   mov ah,9
   mov al,00dah
   mov bl,color
   mov cx,1
   int 10h
   
   mov set_cursor,dx
   inc dl                   ; inc column

;cursor set_cursorition
;----------------------   
   mov ah,2          
   int 10h
   mov set_cursor,dx        ; save cursor set_cursorition 
              
              
   jmp input           
   
   
      
   
   
;     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
;     % printing an elbow while moving DOWN to LEFT %
;     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
;*********   
 downleft:
;*********              
   mov ah,9
   mov al,00d9h
   mov bl,color
   mov cx,1
   int 10h
   
   mov set_cursor,dx
   dec dl
   
;cursor set_cursorition   
;----------------------   
   mov ah,2          
   int 10h
   mov set_cursor,dx        ; save cursor set_cursorition 
   
   jmp input
                       
   
   
   
   
                       
                       
;                     %%%%%%%%%%%%%%%
;                     % DELETE MODE %
;                     %%%%%%%%%%%%%%% 

;********
 Delete:
;********
   mov flag,20h             ; flag if flag is qual to 20h 
   jmp input                ;now input will start deleting   
   
   
   
      
;                 %%%%%%%%%%%%%%%%%%%%%%%%   
;                 % Delete towards RIGHT %
;                 %%%%%%%%%%%%%%%%%%%%%%%%

;***********
 Del_right:
;***********
         
;print function
;--------------         
   mov ah,9            
   mov al,000               ; null character
   mov bl,0     
   mov cx,1
   int 10h
   
   mov dx,set_cursor
   inc dl       
   
;cursor set_cursorition   
;----------------------   
   mov ah,2          
   int 10h
   mov set_cursor,dx        ; save cursor set_cursorition 
   
   jmp input             
   



;***********
 Del_righttilt:
;***********
         
;print function
;--------------         
   mov ah,9            
   mov al,000               ; null character
   mov bl,0     
   mov cx,1
   int 10h
   
   mov dx,set_cursor
   inc dl
   inc dh       
   
;cursor set_cursorition   
;----------------------   
   mov ah,2          
   int 10h
   mov set_cursor,dx        ; save cursor set_cursorition 
   
   jmp input
   
   
   
   
     
   
   
;                 %%%%%%%%%%%%%%%%%%%%%%%   
;                 % Delete towards LEFT %
;                 %%%%%%%%%%%%%%%%%%%%%%%
        
;*********
 Del_left:
;*********
    mov ah,09
    mov al,000
    mov bl,0
    mov cx,1
    int 10h
  
    mov dx,set_cursor
    dec dl
; Cursor set_cursorition
;-----------------------   
    mov ah,2
    int 10h
    mov set_cursor,dx       ; save cursor set_cursorition

    jmp input               
    
;*********
 Del_lefttilt:
;*********
    mov ah,09
    mov al,000
    mov bl,0
    mov cx,1
    int 10h
  
    mov dx,set_cursor
    dec dl
    inc dh
; Cursor set_cursorition
;-----------------------   
    mov ah,2
    int 10h
    mov set_cursor,dx       ; save cursor set_cursorition

    jmp input               
       
    
            
;                 %%%%%%%%%%%%%%%%%%%%   
;                 % Delete towards UP%
;                 %%%%%%%%%%%%%%%%%%%%

;*********
 Del_up:
;**********
    mov ah,09
    mov al,000
    mov bl,0
    mov cx,1
    int 10h         
    
    mov dx,set_cursor
    
    cmp dh,0                ; reaching row no. 0
    je page_change1         ; call set page fuction  
   
    dec dh  

;cursor set_cursoriton 
;---------------------    
    mov ah,2
    int 10h
    mov set_cursor,dx       ; save cursor set_cursorition 
    
    jmp input             
    
    
   
    

;                 %%%%%%%%%%%%%%%%%%%%%%%%   
;                 % Delete towards DOWN  %
;                 %%%%%%%%%%%%%%%%%%%%%%%%


;*********        
 Del_down:
;*********
    mov ah,09
    mov al,000
    mov bl,0
    mov cx,1
    int 10h
    
    mov dx,set_cursor
    
    cmp dh,24               ; set page whn you reachin 24th row
    je page_change
   
    inc dh 

;cursor set_cursorition
;----------------------
    mov ah,2
    int 10h
    mov set_cursor,dx       ; save cursor set_cursorition

    jmp input
  
  
  colors:
  mov flag,2Eh              ; scan code for c
 
  mov ah,7
  int 21h
  sub al,30h                ; subtract ascii 30h from values
  mov color,al
 
  jmp input             
                        
   
   
                        
                        
;            %%%%%%%%%%%%%%%%%%%%%%%%%%%             
;            % Change page moving DOWN %
;            %%%%%%%%%%%%%%%%%%%%%%%%%%%

;**************
  page_change:
;**************    
    inc bh                  ; inc page number
    mov al,bh
    mov ah,5                ; func. 5 used for page seting
    int 10h
    
    mov dh,0

;set cursor set_cursorition
;---------------------------    
    mov ah,02
    int 10h  
    mov set_cursor,dx       ; save cursor set_cursorition
    
    jmp input                 
    
    
   
   
    
    
;            %%%%%%%%%%%%%%%%%%%%%%%%%%%             
;            % Change page moving UP   %
;            %%%%%%%%%%%%%%%%%%%%%%%%%%% 

;***************         
  page_change1:
;*****************    
    dec bh                  ; dec page number 
    mov al,bh
    mov ah,5
    int 10h
    
    mov dh,24      
; cursor set_cursorition 
;-------------------------    
    mov ah,02
    int 10h  
    mov set_cursor,dx       ; save cursor set_cursorition 

    jmp input            
    
    
   
   
    

;                  %%%%%%%%%            
;                  %  EXIT %
;                  %%%%%%%%%

;********              
  Exit:
;********  
  mov ax,4c00h   ; 4c00h exits and give control to operating system
  int 21h
  
   main endp
   end main
                                                          
                                                          
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\                                                          
;/////////////////////////////////////////////////////////////////
           