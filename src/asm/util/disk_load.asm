; julsOS
; disk_load.asm: function to load code in memory
;
; inputs
;   dl: drive
;   ch: cylinder
;   dh: track
;   cl: sector
;   al: number of sectors
;   es:bx: address

disk_load:
    pusha

    mov ah, 0x02  
    int 0x13
    jnc disk_load_end    

    disk_error:
        mov bx, str_disk_error
        call print_string

    disk_load_end:
        popa
        ret

disk_load_fd:
	pusha
	mov dl, [BOOT_DRIVE]
	mov ch, 0 ; cylinder
	mov dh, 0 ; track
	push bx
	mov bx, 0
	mov es, bx  
	pop bx
	call disk_load

	popa

str_disk_error: db "Disk Error",0
