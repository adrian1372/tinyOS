[BITS 32]
global init_kernel
global os_halt

extern puts
extern main

init_kernel:
	call main

	push exitmessage
	call puts
	add ESP, 4

	call os_halt

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


