[org 0x7c00]
[bits 16]

section .text

  global main

main:
; Reset segment regs and set stack pointer to entry point

cli
jmp 0x0000:ZeroSeg	; far jump to correct for BIOS putting us in the wrong segment
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
mov bx, sTwo
mov dl, 0x80
int 0x13

; Load sectors from our disk
mov dl, 0x80
mov al, 2		; sectors to read
mov cl, 2		; start sector
mov bx, sTwo		; offset
; es is already 0
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
;TEST_STR: db 'You are in the second sector.', 0x0a, 0x0d, 0
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

push bx
xor bx, bx
mov es, bx
pop bx

mov dl, 0x80
mov al, 3
mov cl, 3
mov bx, Kernel
call readDisk

cli

mov edi, 0x1000
mov cr3, edi
xor eax, eax
mov ecx, 4096
rep stosd
mov edi, 0x1000

;PML4T -> 0x1000
;PDPT -> 0x2000
;PDT -> 0x3000
;PT -> 0x4000

mov dword [edi], 0x2003
add edi, 0x1000
mov dword [edi], 0x3003
add edi, 0x1000
mov dword [edi], 0x4003
add edi, 0x1000

mov dword ebx, 3
mov ecx, 512

.setEntry:
  mov dword [edi], ebx
  add ebx, 0x1000
  add edi, 8
  loop .setEntry

mov eax, cr4
or eax, 1 << 5
mov cr4, eax

mov ecx, 0xc0000080
rdmsr
or eax, 1 << 8
wrmsr

mov eax, cr0
or eax, 1 << 31
or eax, 1 << 0
mov cr0, eax

lgdt [GDT.Pointer]
jmp GDT.Code:LongMode

TEST_STR: db 'You are in the second sector.', 0x0a, 0x0d, 0

%include "checklm.asm"
%include "gdt.asm"

[bits 64]
LongMode:

VID_MEM equ 0xb8000
mov edi, VID_MEM
mov rax, 0x8f208f208f208f20
mov ecx, 500
rep stosq

jmp Kernel

hlt
times 512-($-$$-512) db 0
;times 1048576 - ($-($$ + 512)) db 0 ; precise padding to fill up 1MB

Kernel:

mov rax, 0x2e658f3d
mov [VID_MEM], rax

mov rax, 0x2e238f658f6e8f73
mov [VID_MEM+4], rax

hlt

times 4096 db 0
;times 5120 db 0
