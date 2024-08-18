[org 0xa100]

pusha
mov bx, str_juss
call print_string
call break_line
popa
ret
 
str_juss: db "hello juss, jejje",0

%include "print_string.asm"
