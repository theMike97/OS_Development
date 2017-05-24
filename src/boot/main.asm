[org 0x7c00]
[bits 16]

section .text

  global main

main:
mov si, LOADING
call printf

; Reset segment regs and set stack pointer to entry point
cli
jmp 0x0000:ZeroSeg	; far jump to correct for BIOS puttin us in the wrong segment
ZeroSeg:
  xor ax, ax
  mov ss, ax
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov sp, main
  cld
sti

; Reset disk
push ax
xor ax, ax
mov dl, 0x80
int 0x13
; Load sectors from our disk
mov al, 1		; sectors to read
mov cl, 2		; start sector
mov dx, [0x7c00 + 510]	; print out 
call printh

jmp $

%include "printf.asm"
%include "readDisk.asm"
%include "printh.asm"

LOADING: db 'Loading...', 0x0a, 0x0d, 0
DISK_ERR_MSG: db 'Error Loading Disk.', 0x0a, 0x0d, 0
TEST_STR: db 'You are in the second sector.', 0x0a, 0x0d, 0

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55

sTwo:
mov si, TEST_STR
call printf
;
times 512 db 0 ; extra padding so QEmu doesn't think we've run out of disk space
