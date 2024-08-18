; julsOS
; kernel.asm: kernel to be loaded in memory

load_fs:
	mov dl, [BOOT_DRIVE]
	mov ch, 0 ;cylinder
	mov dh, 0 ;track
	mov cl, 4 ;sector
	mov al, 4 ;numbers of sectors to be copied 
	mov bx, 0
	mov es, bx  
	mov bx, [FILE_DESCRIPTOR_START] ;copy content of sectors to ES:BX
	call disk_load


;print welcome message
mov bx, str_welcome
call print_string
call break_line

jmp shell 

str_welcome: db "welcome to julsOS!",0

shell:
    %include "bin/shell.asm"


