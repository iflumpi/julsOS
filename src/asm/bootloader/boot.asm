; julsOS
; boot.asm: bootloader
;
;	print a message
;	copy kernel to memory
;	execute kernel

[org 0x7c00]

mov [BOOT_DRIVE], dl ;BIOS stores current drive id in DL register

mov bx, str_mbr
call print_string
call break_line
call break_line

mov dl, [BOOT_DRIVE]
mov ch, 0 ;cylinder
mov dh, 0 ;track
mov cl, 2 ;sector
mov al, 2 ;numbers of sectors to be copied 
mov bx, 0
mov es, bx  
mov bx, [KERNEL_START] ;copy content of sectors to ES:BX
call disk_load

call [KERNEL_START] ;jump to the loaded code after boot sector
jmp $

;functions
%include "util/disk_load.asm"
%include "util/print_string.asm"
    
;variables
BOOT_DRIVE: db 0
KERNEL_START: dw 0x7e00
str_mbr: db "initiating julsOS bootloader...",0

end: ;write magic word (0xaa55) in last word of sector
    times 510-($-$$) db 0
    dw 0xaa55

;write kernel code to 2th sector
%include "kernel/kernel.asm"
