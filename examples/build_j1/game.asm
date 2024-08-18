[org 0xa100]

pusha
mov bx, str_press
call print_string
call break_line
popa

; wait until a key is pressed
mov ah, 0
int 0x16

mov ax, 0x13
int 0x10

; video memory address
mov ax, 0xA000
mov es, ax

mov bx, 1
mov di, 0
loop_graphics:
    mov ah, 1
    int 0x16
    jz loop_graphics_nkp

    mov ah, 0
    int 0x16
    cmp al, 'j'
    je j_pressed 
    cmp al, 'l'
    je l_pressed
    mov bx, 1
    jmp loop_graphics_nkp 

    j_pressed:
        mov bx, 320
        jmp loop_graphics_nkp 

    l_pressed:
        mov bx, 1
        jmp loop_graphics_nkp 

    loop_graphics_nkp:

        cmp bx, 1
        je uses_horizontal
        cmp bx, 320
        je uses_vertical
        jmp loop_graphic_main 

        uses_horizontal:
            cmp di, 320
            jge loop_graphics
            jmp loop_graphic_main 

        uses_vertical:
            jmp loop_graphic_main 
            cmp di, 64000 
            jge loop_graphics

        loop_graphic_main:  
            push cx
            mov cx, 0
            mov dx, 0520h
            mov ah, 86h
            int 15h
            pop cx 

            mov al, 28h
            mov [es:di], al
            add di, bx 
            
            jnz loop_graphics

graphics_end:

mov ax, 0x03
int 0x10

delay_loop:
    dec cx
    jnz delay_loop
    ret

ret

str_press: db "presiona una tecla para ver algo maravilloso",0

%include "print_string.asm"
