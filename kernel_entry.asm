[BITS 32]
global init_kernel
global os_halt
global _idt_load

extern puts
extern main
extern idtp
extern DATA_SEG
extern fault_handler
extern irq_handler

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

_idt_load:
	lidt [idtp]
	ret


; Interrupt Service Routines - [0-31] are EXCEPTIONS
global _isr0		; Division by Zero Exception
global _isr1		; Debug Exception
global _isr2		; Non Maskable Interrupt Exception
global _isr3		; Breakpoint Exception
global _isr4		; Into Detected Overflow Exception
global _isr5		; Out of Bounds Exception
global _isr6		; Invalid Opcode Exception
global _isr7		; No Coprocessor Exception
global _isr8		; Double Fault Exception					[EC]
global _isr9		; Coprocessor Segment Overrun Exception
global _isr10		; Bad TSS Exception							[EC]
global _isr11		; Segment Not Present Exception				[EC]
global _isr12		; Stack Fault Exception						[EC]
global _isr13		; General Protection Fault Exception		[EC]
global _isr14		; Page Fault Exception						[EC]
global _isr15		; Unknown Interrupt Exception
global _isr16		; Coprocessor Fault Exception
global _isr17		; Alignment Check Exception (486+)
global _isr18		; Machine Check Exception (Pentium/586+)
global _isr19		; Reserved Exception
global _isr20		; ...
global _isr21		; ...
global _isr22		; ...
global _isr23		; ...
global _isr24		; ...
global _isr25		; ...
global _isr26		; ...
global _isr27		; ...
global _isr28		; ...
global _isr29		; ...
global _isr30		; ...
global _isr31		; Reserved Exception


;	0: Divide By Zero Exception
_isr0:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 0		; Also push the index of this ISR
	jmp isr_common_stub

_isr1:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 1		; Also push the index of this ISR
	jmp isr_common_stub

_isr2:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 2		; Also push the index of this ISR
	jmp isr_common_stub

_isr3:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 3		; Also push the index of this ISR
	jmp isr_common_stub

_isr4:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 4		; Also push the index of this ISR
	jmp isr_common_stub

_isr5:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 5		; Also push the index of this ISR
	jmp isr_common_stub

_isr6:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 6		; Also push the index of this ISR
	jmp isr_common_stub

_isr7:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 7		; Also push the index of this ISR
	jmp isr_common_stub

_isr8:
	cli
	push byte 8		; Also push the index of this ISR
	jmp isr_common_stub

_isr9:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 9		; Also push the index of this ISR
	jmp isr_common_stub

_isr10:
	cli
	push byte 10	; Also push the index of this ISR
	jmp isr_common_stub

_isr11:
	cli
	push byte 11	; Also push the index of this ISR
	jmp isr_common_stub

_isr12:
	cli
	push byte 12	; Also push the index of this ISR
	jmp isr_common_stub

_isr13:
	cli
	push byte 13	; Also push the index of this ISR
	jmp isr_common_stub


_isr14:
	cli
	push byte 14	; Also push the index of this ISR
	jmp isr_common_stub


_isr15:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 15	; Also push the index of this ISR
	jmp isr_common_stub


_isr16:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 16	; Also push the index of this ISR
	jmp isr_common_stub


_isr17:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 17	; Also push the index of this ISR
	jmp isr_common_stub


_isr18:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 18	; Also push the index of this ISR
	jmp isr_common_stub


_isr19:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 19	; Also push the index of this ISR
	jmp isr_common_stub


_isr20:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 20	; Also push the index of this ISR
	jmp isr_common_stub


_isr21:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 21	; Also push the index of this ISR
	jmp isr_common_stub


_isr22:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 22	; Also push the index of this ISR
	jmp isr_common_stub


_isr23:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 23	; Also push the index of this ISR
	jmp isr_common_stub


_isr24:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 24	; Also push the index of this ISR
	jmp isr_common_stub


_isr25:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 25	; Also push the index of this ISR
	jmp isr_common_stub


_isr26:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 26	; Also push the index of this ISR
	jmp isr_common_stub


_isr27:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 27	; Also push the index of this ISR
	jmp isr_common_stub


_isr28:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 28	; Also push the index of this ISR
	jmp isr_common_stub


_isr29:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 29	; Also push the index of this ISR
	jmp isr_common_stub


_isr30:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 30	; Also push the index of this ISR
	jmp isr_common_stub


_isr31:
	cli
	push byte 0		; Dummy error code, all exceptions not marked with [EC] above need this
	push byte 31	; Also push the index of this ISR
	jmp isr_common_stub


isr_common_stub:
	pusha
	push ds
	push es
	push fs
	push gs
	
	mov ax, DATA_SEG			; Load the Kernel Data Segment Descriptor
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	
	mov eax, esp				; Push the stack-ptr to stack
	push eax

	mov eax, fault_handler		; C function to handle faults (interrupts/exceptions)
	call eax					; Special call that preserves the EIP register
	
	pop eax
	pop gs
	pop fs
	pop es
	pop ds
	popa

	add esp, 8					; Clean up the pushed error code and ISR number
	iret						; Special return, pops CS, EIP, EFLAGS, SS and ESP

; Interrupt Requests (IRQs)
global _irq0
global _irq1
global _irq2
global _irq3
global _irq4
global _irq5
global _irq6
global _irq7
global _irq8
global _irq9
global _irq10
global _irq11
global _irq12
global _irq13
global _irq14
global _irq15

_irq0:
	cli
	push byte 0
	push byte 32
	jmp irq_common_stub

_irq1:
	cli
	push byte 0
	push byte 33
	jmp irq_common_stub

_irq2:
	cli
	push byte 0
	push byte 34
	jmp irq_common_stub

_irq3:
	cli
	push byte 0
	push byte 35
	jmp irq_common_stub

_irq4:
	cli
	push byte 0
	push byte 36
	jmp irq_common_stub

_irq5:
	cli
	push byte 0
	push byte 37
	jmp irq_common_stub

_irq6:
	cli
	push byte 0
	push byte 38
	jmp irq_common_stub

_irq7:
	cli
	push byte 0
	push byte 39
	jmp irq_common_stub

_irq8:
	cli
	push byte 0
	push byte 40
	jmp irq_common_stub

_irq9:
	cli
	push byte 0
	push byte 41
	jmp irq_common_stub

_irq10:
	cli
	push byte 0
	push byte 42
	jmp irq_common_stub

_irq11:
	cli
	push byte 0
	push byte 43
	jmp irq_common_stub

_irq12:
	cli
	push byte 0
	push byte 44
	jmp irq_common_stub

_irq13:
	cli
	push byte 0
	push byte 45
	jmp irq_common_stub

_irq14:
	cli
	push byte 0
	push byte 46
	jmp irq_common_stub

_irq15:
	cli
	push byte 0
	push byte 47
	jmp irq_common_stub

; Common stub for handling Interrupt Requests
; Identical to ISR stub, except that this calls the
; C IRQ Handler
irq_common_stub:
	pusha
	push ds
	push es
	push fs
	push gs
	
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov eax, esp
	push eax

	mov eax, irq_handler
	call eax

	pop eax
	pop gs
	pop fs
	pop es
	pop ds
	popa

	add esp, 8
	iret

exitmessage: db 0x0A, "Reached end of kernel, halting execution...", 0x0


