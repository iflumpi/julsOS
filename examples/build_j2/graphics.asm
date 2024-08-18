[org 0xa100]

pusha
mov bx, str_juss
call print_string
call break_line
popa

mov ax, 0x13
int 0x10

mov ax, 0x10
int 0x10

ret
 
str_juss: db "hello juss, jejje",0

%include "print_string.asm"
