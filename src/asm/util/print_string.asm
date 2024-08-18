; julsOS
; print_string.asm: function to print a string
;
; inputs
;   bx: string to print

print_string:
    pusha
    mov ah, 0x0e
    ps_loop:        
        mov al, [bx]
        cmp al, 0
        je ps_end
        int 0x10
        inc bx
        jmp ps_loop
    ps_end:
        popa
        ret

; function
;	break_line
break_line:
	pusha
	mov ah, 0x0e
	mov al, 10
	int 0x10
	mov al, 13
	int 0x10
	popa
	ret
