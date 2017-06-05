; Test the A20 Line
testA20:

pusha

mov ax, [0x7dfe]
mov dx, ax
call printh

push bx
mov bx, 0xffff
mov es, bx
pop bx

mov bx, 0x7e0e

mov dx, [es:bx]
call printh

cmp ax, dx
je .cont

popa
mov ax, 1
ret

.cont:
mov ax, [0x7dff]
mov dx, ax
call printh

push bx
mov bx, 0xffff
mov es, bx
pop bx

mov bx, 0x7e0f

mov dx, [es:bx]
call printh

cmp ax, dx
je .exit

popa
mov ax, 1
ret

.exit:
popa
xor ax, ax
ret

;0xffff0 + offset = 0x107dfe
;offset = 0x107dfe - 0xffff0
;offset = 0x7e0e
