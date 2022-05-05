%macro rw 03

mov rax, %1
mov rdi, 01
mov rsi, %2
mov rdx, %3
syscall

%endmacro rw

section .data
s1 db "Enter num: "
l1 equ $-s1
s2 db "You entered: "
l2 equ $-s2
br db 10
count db 05h


section .bss
arr resb 85


global _start
section .text
_start:
	mov byte[count], 05h
	mov rbx, arr
	rw 01,s1,l1
	rw 01,br,1
	
	read:
		rw 00,rbx,11h
		syscall 
		
		add rbx,11h
		dec byte[count]
		jnz read

	rw 01, br,1
	rw 01,s2,l2
	rw 01,br,1
	
	mov byte[count], 05h
	mov rbx, arr
	
	write:
		rw 01,rbx,11h
		add rbx,11h
		dec byte[count]
		jnz write
	mov rax, 60
	mov rdi, 00
	syscall
		
	

