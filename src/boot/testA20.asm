; Test the A20 Line
testA20:

pusha

mov ax, [0x7dfe]  ; 7dfe = 7c00+510 (memory location of magic number)
                  ; create a reference to check for wrapping
; set es to zero
push bx
mov bx, 0xffff
mov es, bx
pop bx

mov bx, 0x7e0e    ; set offset to 0x7e0e

mov dx, [es:bx]   ; print the contents located in the segment

cmp ax, dx        ; compare the segment to the reference
je .cont          ; if (ax == dx) {jmp to .cont}

popa              ; else { popa
mov ax, 1         ; set ax to 1 as a return value
ret               ; return }


; for this section, do the same as what was done above
; except shift the reference (and thus the offset) location
; one byte for confirmation

.cont:
mov ax, [0x7dff]

push bx
mov bx, 0xffff
mov es, bx
pop bx

mov bx, 0x7e0f
mov dx, [es:bx]

cmp ax, dx      ; if (ax == dx) {exit}
je .exit

popa
mov ax, 1       ; else {...}
ret

.exit:
popa
xor ax, ax      ; set ax to 0 as return value
ret

; this is the process used to figure out the offset for the magic
; number given the segment is 0xffff
;0xffff0 + offset = 0x107dfe
;offset = 0x107dfe - 0xffff0
;offset = 0x7e0e
