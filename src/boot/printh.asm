printh:
push cx
push di
push bx

mov si, HEX_PATTERN		; Load HEX_PATTERN memory location to si
mov cl, 12
mov di, 2

.hexLoop:
  mov bx, dx			; copy dx to bx to preserve original hex value
  shr bx, cl			; Shift value in bx 12 bits (3 bytes) right
  and bx, 0x000f  ; mask first 3 digits
  mov bx, [bx + HEX_TABLE]	; load ascii character from HEX_TABLE into bx
  mov [HEX_PATTERN + di], bl	; insert byte bl into correct spot in HEX_PATTERN
  sub cl, 4       ; change bits shifted in next iteration
  inc di          ; add 1 to insertion location in HEX_PATTERN
  
  cmp di, 6       ; since HEX_PATTERN.length = 5:
  je .exit        ; if (di == 6) {exit the loop}

jmp .hexLoop

.exit:
call printf     ; print HEX_PETTERN which is now populated

pop bx
pop di
pop cx
ret

HEX_PATTERN: db '0x****', 0x0a, 0x0d, 0
HEX_TABLE: db '0123456789abcdef'
