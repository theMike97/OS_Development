GDT:
  .Null: equ $ - GDT
    dw 0
    dw 0
    db 0
    db 0
    db 0
    db 0

  .Code: equ $ - GDT
    dw 0
    dw 0
    db 0
    db 10011000b
    db 00100000b
    db 0

  .Data: equ $ -GDT
    dw 0
    dw 0
    db 0
    db 10000000b
    db 0
    db 0

  .Pointer:
    dw $ - GDT - 1
    dq GDT
