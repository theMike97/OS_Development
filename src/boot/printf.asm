printf:
  pusha
  mov ah, 0x0e		; Teletype output function
  str_loop:
    mov al, [si]	; Load a character byte to al
    cmp al, 0
    jne print_char	; if al != 0, jmp to print_char
    popa
    ret

  print_char:
    int 0x10		; 0x10 interrupt
    inc si		; add 1 to si
    jmp str_loop
