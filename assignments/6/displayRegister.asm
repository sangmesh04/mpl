%macro print 2
mov rax,01
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

section .data
msg1 db "Contents of GDT are: "
len1 equ $-msg1
msg2 db "Contents of LDT are: "
len2 equ $-msg2
msg3 db "Contents of IDT are: "
len3 equ $-msg3
msg4 db "Contents of Task Register are: "
len4 equ $-msg4
msg5 db "Contents of Machine Status Word are: "
len5 equ $-msg5
msg6 db "CPU is in Protected Mode.", 10
len6 equ $-msg6
msg7 db "CPU is in Real Mode.", 10
len7 equ $-msg7
msg8 db "Processor switched to Protected mode.", 10
len8 equ $-msg8
colmsg db ':'
newl db "", 10
l equ $-newl

section .bss
	gdt resd 1
	    resw 1
	ldt resw 1
	idt resd 1
	    resw 1
	tr  resw 1
	cr0_data resd 1
	dnum_buff resb 04

section .text
global _start
_start:
	bts rax, 1
	jc prmod
	print msg7, len7
	print msg8, len8
	jmp _start
	jmp nxt
	prmod: print msg6, len6
nxt:
	sgdt [gdt]
	sldt [ldt]
	sidt [idt]
	str [tr]
	
	print msg1, len1
	mov bx,[gdt+4]
	call print_num
	mov bx,[gdt+2]
	call print_num
	print colmsg,1
	mov bx,[gdt]
	call print_num
	print newl, l
	
	print msg2, len2
	mov bx,[ldt]
	call print_num
	print newl, l
	
	print msg3, len3
	mov bx,[idt+4]
	call print_num
	mov bx,[idt+2]
	call print_num
	print colmsg,1
	mov bx,[idt]
	call print_num
	print newl, l
	
	print msg4, len4
	mov bx,[tr]
	call print_num
	print newl, l
	
	print msg5, len5
	mov bx,[cr0_data+2]
	call print_num
	mov bx,[cr0_data]
	call print_num
	print newl, l
	
exit:
	mov rax,60
	mov rdi,00
	syscall

print_num:
	mov rsi,dnum_buff
	mov rcx,04
	
up1:
	rol bx,4	
	mov dl,bl		
	and dl,0fh		
	add dl,30h		
	cmp dl,39h		
	jbe skip1		
	add dl,07h	
		
skip1:
	mov [rsi],dl	
	inc rsi			
	loop up1		
	print dnum_buff,4	
	ret
