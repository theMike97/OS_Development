readDisk:
  pusha

  ; we assume al and cl are set outside this function

  mov ah, 0x02		; read sectors from drive function
;  mov dl, 0x00		; select drive medium (floppy or hdd/sdd)
  mov ch, 0		; select start cylinder
  mov dh, 0		; select start head

  ;mov bx, 0x7e00	; set offset address (sector 2 address)

  int 0x13		; call interrupt

  jc disk_err		; if carry flag is set, jmp to disk_err
  popa
  ret

  disk_err:
    mov si, DISK_ERR_MSG
    call printf
    jmp $
