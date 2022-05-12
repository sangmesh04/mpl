section .data
msg1 db "The max of given array: "
len1 equ $ -msg1
br db 10

array db 04h,03h,05h,08h,01h

%macro print 2
mov rax,01
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

section .bss
count resb 02h
maxVal resb 02h

section .text

global _start
_start:
mov byte[count],05h
mov byte[maxVal],00h

mov rsi,array
mov al,00

loop:
cmp [rsi],al
jns setVal
jmp down

setVal:
mov al,[rsi]
mov byte[maxVal],al

down:
add rsi,01h
dec byte[count]
jnz loop

print msg1,len1

mov al,byte[maxVal]
call _asciilen
mov byte[maxVal],al
print maxVal, 02h
print br,02h



mov rax,60
mov rdi,00
syscall

_asciilen:
cmp al , 09h
jbe exp
add al,07h
exp:add al,30h
ret
