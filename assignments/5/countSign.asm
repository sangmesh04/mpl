section .data
msg1 db "Number of positive numbers : "
len1 equ $ -msg1
msg2 db 10, "Number of negative numbers : "
len2 equ $ -msg2
br db 10

array db 24,-2,18,-10,-6,8,3,-8,54,6

%macro print 2
mov rax,01
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

section .bss
count resb 2
pcount resb 2
ncount resb 2

section .text
global _start
_start:
mov byte[count],10
mov byte[pcount],00
mov byte[ncount],00
mov rsi,array
loop:
mov al,00
add al,[rsi]
js neg
inc byte[pcount]
jmp down
neg:
inc byte[ncount]
down:
add rsi,01
dec byte[count]
jnz loop
print msg1,len1
mov al,byte[pcount]
call _asciilen
mov byte[pcount],al

print pcount,02
print msg2,len2
mov al,byte[ncount]
call _asciilen
mov byte[ncount],al
print ncount,02
print br,01h

mov rax,60
mov rdi,00
syscall
_asciilen:
cmp al , 09
jbe exp
add al,07h
exp:add al,30h
ret

