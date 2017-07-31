[org 0x7c00]
[bits 16]

section .text

  global main

main:
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

mov si, LOADING
call printf

; Reset disk
xor ax, ax
mov dl, 0x00
int 0x13

; Load sectors from our disk
mov al, 1		; sectors to read
mov cl, 2		; start sector
call readDisk

;mov ax, 0x2400
;int 0x15

call testA20
mov dx, ax
call printh

call enableA20

jmp sTwo

jmp $ ;safety hang

%include "printf.asm"
%include "readDisk.asm"
%include "printh.asm"
%include "testA20.asm"
%include "enableA20.asm"

LOADING: db 'Loading...', 0x0a, 0x0d, 0
DISK_ERR_MSG: db 'Error Loading Disk.', 0x0a, 0x0d, 0
TEST_STR: db 'You are in the second sector.', 0x0a, 0x0d, 0
NO_A20: db 'No A20 line.', 0x0a, 0x0d, 0
A20DONE: db 'A20 Line Enabled.', 0x0a, 0x0d, 0
NO_LM: db 'No long mode support.', 0x0a, 0x0d, 0
YES_LM: db 'Long Mode supported.', 0x0a, 0x0d, 0

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55

sTwo:
mov si, TEST_STR
call printf

call checklm

jmp $

%include "checklm.asm"

times 512 db 0 ; extra padding so QEmu doesn't think we've run out of disk space
