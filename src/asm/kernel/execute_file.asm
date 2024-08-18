; julsOS
; execute_file.asm: execute a file
;
;   - outputs:
;       - dl (1 if found else 0)
;   - actions:
;       - search for a file in the 2th sector
;       - if found:
;           - load file to memory
;           - execute code

execute:
    pusha
	mov bx, [FILE_DESCRIPTOR_START]

	execute_loop:
		mov cx, [bx]
		cmp cx, 0x11FF
		jne ls_end	
		add bx, 2 ;file
		mov cx, bx
		call string_equals
		cmp dl, 1
		je execute_file 
		add bx, 8 ;start file
		add bx, 2 ;end file
		add bx, 2
		jmp execute_loop

	execute_file:
		add bx, 8 ;start file
		mov dl, [BOOT_DRIVE]
		mov ch, 0 ;cylinder
		mov dh, 0 ;track
		mov cl, [bx] ;sector
		mov al, 1 ;numbers of sectors to be copied 
		mov bx, 0
		mov es, bx  
		mov bx, [EXECUTABLE_START] ;copy content of sectors to ES:BX
		call disk_load
		
		mov dl, [env_debug]
        cmp dl, 1
        jne ef_call
        call break_line
		mov bx, str_file_found	
		call print_string
		call break_line
		
        ef_call:        
		    call break_line
    		call [EXECUTABLE_START]	
		
		popa
		mov dl, 1
		ret

	execute_end:
		popa
		mov dl, 0
		ret

EXECUTABLE_START: dw 0xA100 ;address to load executable files
FILE_DESCRIPTOR_START: dw 0x8000
str_file_found: db "executing file",0
