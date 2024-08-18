; julsOS
; string_equals.asm: compare two strings 
;
; inputs
;	ax, bx: strings to compare
; outputs
;	dl: 1 if equals, else 0

string_equals:
	pusha
	se_loop:
		mov bx, ax
		mov dl, [bx]
		mov bx, cx
		mov dh, [bx]
		cmp dl, dh	
		jne se_not_equals
		cmp dl, 0
		je se_equals
		inc ax
		inc cx
		jmp se_loop	
	se_not_equals:
		popa
		mov dl, 0
		ret
	se_equals:
		popa
		mov dl, 1
		ret
