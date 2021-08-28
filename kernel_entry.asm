%ifndef __KERNEL_ENTRY_ASM__
%define __KERNEL_ENTRY_ASM__
[BITS 32]

extern puts
extern main

call main

push exitmessage
call puts
add ESP, 4

global os_halt
os_halt:
	jmp $
	cli
	hlt


exitmessage: db 0x0A, "Reached end of kernel, halting execution...", 0x0

section .bss
align 4

kernel_stack_bottom: equ $
	resb 16384
kernel_stack_top:

%endif

