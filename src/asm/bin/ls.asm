; julsOS
; ls.asm: execute a file
;
; - read the filenames from filesystem
;   + system file
;   + descriptors of file
;     + 11ff
;     + filename
;     + start_address
;     + end_address
;
; - print filenames

ls:
	pusha
	mov dl, [BOOT_DRIVE]
	mov ch, 0 ; cylinder
	mov dh, 0 ; track
	mov cl, 4 ; sector
	mov al, 2 ; numbers of sectors to be copied 
	mov bx, 0
	mov es, bx  
	mov bx, 0x8000 ;copy content of sectors to ES:BX
	call disk_load
	
	mov bx, 0x8000
	ls_loop:
		mov ax, [bx]
		cmp ax, 0x11FF
		jne ls_end	
		call break_line
		add bx, 2
		call print_string
		add bx, 8
		add bx, 2
		add bx, 2
		jmp ls_loop

	ls_end:
		popa
		ret

