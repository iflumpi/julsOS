; julsOS
; shell.asm: shell to read commands from keyboard
;
;   read command from keyboard	
;	process command
;       - ls
;       - set debug mode
;       - clear
;       - executable files

get_command: ;print prompt and read input from user
	call break_line
	mov bx, prompt
	call print_string
	mov bx, input_cmd 

get_command_loop: ;loop to read command from keyboard
	mov ah, 0
	int 0x16
	cmp al, 13
	je process_command 
	cmp al, 131
	je process_command 
	mov [bx], al
	inc bx
    mov ah, 0x0e	
	int 0x10
	jmp get_command_loop

process_command: ;process input command
	mov al, 0
	mov [bx], al
	
	;ls command
	mov ax, input_cmd
	mov cx, cmd_ls
	call string_equals
	cmp dl, 1	
	je execute_ls

    ;clear command
    mov cx, cmd_clear
    call string_equals
    cmp dl, 1
    je execute_clear
    
	;set_debug command
	mov cx, cmd_set_debug
	call string_equals
	cmp dl, 1
	je execute_set_debug

    ;execute file if found
	call execute
	cmp dl, 1	
	jne pc_not_found
	jmp get_command	

	execute_ls: ;execute ls command
		call ls
		jmp get_command

    execute_clear: ;execute clear command
        mov ah, 0x06
        mov al, 0
        mov bh, 0x07
        mov cx, 0
        mov dx, 0x184f
        int 10h
        jmp get_command

    execute_set_debug: ;set debug  mode
        mov dl, [env_debug]
        cmp dl, 1
        jne set_debug
        mov dh, 0x00
        mov bx, str_debug_mode_disabled
        jmp switch_debug
        set_debug:
            mov dh, 0x01
            mov bx, str_debug_mode_enabled
        switch_debug:
            mov [env_debug], dh
            call break_line
            call print_string
            jmp get_command

	pc_not_found: ;print not_found message
		call break_line
		mov bx, str_command_not_found
		call print_string
		jmp get_command 

;functions
%include "bin/ls.asm"
%include "kernel/execute_file.asm"
%include "util/string_equals.asm"

;variables
prompt: db "> ",0
str_command_not_found: db "command not found",0
str_debug_mode_enabled: db "debug mode enabled",0
str_debug_mode_disabled: db "debug mode disabled",0
cmd_ls: db "ls",0
cmd_clear: db "clear",0
cmd_set_debug: db "set_debug",0
input_cmd:
	times 40 db 0
env_debug: db 0

