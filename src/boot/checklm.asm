checklm:
pusha

pushfd            ; push EFLAGS to the stack
pop eax           ; pop EFLAGS from stack to EAX
mov ecx, eax      ; back up EAX in ECX

xor eax, 1 << 21  ; FLIP 21st bit of EAX to 1 if it isn't already

push eax          ; lines 10-14 put EAX back into EFLAGS and then back into EAX
popfd

pushfd
pop eax

xor eax, ecx      ; return true (1) if EAX and original EFLAGS (backed up in ECX) are different
jz .done          ; if 0, jump to .done

; test if cpuid supports extended processor info
mov eax, 0x80000000
cpuid
cmp eax, 0x80000001 ; eax must be larger than or equal to 0x80000001
jb .done            ; if it is not, jump to .done

; test if CPU supports long mode
mov eax, 0x80000001
cpuid
test edx, 1 << 29 ; if the 29th bit of edx is 1, we have long mode
jz .done          ; if not, jump to .done

mov si, YES_LM
call printf       ; print success feedback
popa
ret

.done:
popa
mov si, NO_LM
call printf
jmp $             ; hang after printing error message
