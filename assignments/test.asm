%macro print 2
mov rax, 01
mov rdi,01
mov rsi, %1
mov rdx,%2
syscall
%endmacro

%macro read 2
mov rax, 00
mov rdi,00
mov rsi, %1

mov rdx, %2
syscall
%endmacro

section .data
num1 dq 25
num2 dq 5
cnt: db 00h
functions: db "<--- Menu --->",10,"1. Add",10,"2. Subtract",10,"3. Multiply",10,"4. Division",10,"5. Exit",10
func: equ $-functions
choice: db 00h
q :db "Quotient : "
m1: equ $-q

section .bss
var resb 16
inp resb 16

section .text

global _start

_start:

print functions,func
read choice,1
cmp byte[choice],31h
JE one
cmp byte[choice],32h
JE two
cmp byte[choice],33h
JE three
cmp byte[choice],34h
JE four
JMP exit

one : call ADDITION
JMP exit
two : call SUBTRACTION
JMP exit
three : call MULTIPLICATION
JMP exit
four : call DIVISION
JMP exit

exit:
mov rax,60
mov rdi,0

syscall

ADDITION:
mov rax,[num1]
mov rbx,[num2]
add rax,rbx
call HextoA
ret

SUBTRACTION:
mov rax,[num1]
mov rbx,[num2]
sub rax,rbx
call HextoA
ret

MULTIPLICATION:
mov rax,[num1]
mov rbx,[num2]
mul rbx
mov r9,rax
xor rax,rax
mov rax,rdx
call HextoA

xor rax,rax
mov rax,r9
call HextoA
ret

DIVISION:
mov rax,[num1]
mov rbx,[num2]
xor rdx,rdx
div rbx
mov r9,rax
print q,m1
mov rax,r9
call HextoA
ret

HextoA:
mov rbx,var
mov byte[cnt],10h
M:
rol rax,04
mov cl,al
and cl,0x0F
cmp cl,09h
JBE L

add cl,07h
L: add cl,30h
mov byte[rbx],cl
inc rbx
dec byte[cnt]
jnz M
mov r8,var
mov bl,16h
P: print r8,1
inc r8
dec bl
jnz P
ret
