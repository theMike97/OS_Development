GDT:
  .Null: equ $ - GDT	; mandatory null descriptor
  dw 0			; low limit
  dw 0			; low base
  db 0			; mid base
  db 0			; access permissions
  db 0			; granularity
  db 0			; high base
  
  .Code: equ $ - GDT	; code descriptor
  dw 0
  dw 0
  db 0
  db 10011010b		; access (exec/read)
  db 00100000b		; granularity
  db 0

  .Data: equ $ - GDT	; data descriptor
  dw 0
  dw 0
  db 0
  db 10010010b		; access (read/write)
  db 00000000b		; granularity
  db 0

  .Pointer:		; gdt pointer (what we use to load the gdt)
  dw $ - GDT - 1	; end of gdt
  dq GDT		; start of gdt
