%macro rw 03

mov rax, %1
mov rdi, 01
mov rsi, %2
mov rdx, %3
syscall

%endmacro rw

section .data
s1 db "Enter string: "
l1 equ $-s1
s2 db "The length of string is: "
l2 equ $-s2

br db 10

slen db 00h

count db 0Fh

section .bss
mystr resb 0Fh
cnt resb 01h
asciiarr resb 02h

global _start
section .text
_start:

	mov byte[count], 0Fh
	mov rsi, mystr
	rw 01,s1,l1
	rw 01,br,1
	rw 00,mystr,0Fh
	
	
		
		
	read:
		mov al,[rsi]
		cmp al,0Ah
		jz htoa
		inc byte[slen]
		inc rsi
		dec byte[count]
		syscall
		jnz read
		
	;call htoa
	;	mov rax, 60
	;	mov rdi, 00
	;	syscall
	
	htoa:
		mov rsi, asciiarr
		mov byte[cnt], 02h
		mov al, byte[slen]
		
	again:
		rol al, 04h
		mov bl, al
		and bl, 0fh
		cmp bl, 09h
		jbe add30
		add bl, 07h
	
	add30:
		add bl, 30h
		mov [rsi], bl
		inc rsi
		dec byte[cnt]
		jnz again
	
	out:
		rw 01, s2, l2
		rw 01, asciiarr,02h
		rw 01, br, 01h
	
	
	;ret
	mov rax, 60
	mov rdi, 00
	syscall
	

