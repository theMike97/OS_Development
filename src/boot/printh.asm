printh:

mov si, HEX_PATTERN		; Load HEX_PATTERN memory location to si

mov bx, dx			; copy dx to bx to preserve original hex value
shr bx, 12			; Shift value in bx 12 bits (3 bytes) right
mov bx, [bx + HEX_TABLE]	; load ascii character from HEX_TABLE into bx
mov [HEX_PATTERN + 2], bl	; insert byte bl into correct spot in HEX_PATTERN

mov bx, dx
shr bx, 8
and bx, 0x000f			; mask digits except the first one
mov bx, [bx + HEX_TABLE]
mov [HEX_PATTERN + 3], bl

mov bx, dx
shr bx, 4
and bx, 0x000f
mov bx, [bx + HEX_TABLE]
mov [HEX_PATTERN + 4], bl

mov bx, dx
and bx, 0x000f
mov bx, [bx + HEX_TABLE]
mov [HEX_PATTERN + 5], bl

call printf			; print HEX_PATTERN which now is populated with the address
ret

HEX_PATTERN: db '0x****', 0x0a, 0x0d, 0
HEX_TABLE: db '0123456789abcdef'
