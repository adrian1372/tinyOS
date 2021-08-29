#include <tinyos/kernel/idt.h>
#include <tinyos/string.h>
#include <tinyos/kernel/system.h>
#include <tinyos/stdio.h>

/* ISR[0-31] are reserved by Intel to service exceptions */
extern void _isr0();
extern void _isr1();
extern void _isr2();
extern void _isr3();
extern void _isr4();
extern void _isr5();
extern void _isr6();
extern void _isr7();
extern void _isr8();
extern void _isr9();
extern void _isr10();
extern void _isr11();
extern void _isr12();
extern void _isr13();
extern void _isr14();
extern void _isr15();
extern void _isr16();
extern void _isr17();
extern void _isr18();
extern void _isr19();
extern void _isr20();
extern void _isr21();
extern void _isr22();
extern void _isr23();
extern void _isr24();
extern void _isr25();
extern void _isr26();
extern void _isr27();
extern void _isr28();
extern void _isr29();
extern void _isr30();
extern void _isr31();

struct idt_entry idt[256];
struct idt_ptr idtp;

const char *_exception_messages[] =
{
	"Division By Zero",
	"Debug",
	"Non Maskable Interrupt",
	"Breakpoint",
	"Into Detected Overflow",
	"Out Of Bounds",
	"Invalid Opcode",
	"No Coprocesor",
	"Double Fault",
	"Coprocessor Segment Overrun",
	"Bad TSS",
	"Segment Not Present",
	"Stack Fault",
	"General Protection Fault",
	"Page Fault",
	"Unknown Interrupt",
	"Coprocessor Fault",
	"Alignment Check",
	"Machine Check",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved"
};

void isrs_install()
{
	idt_set_gate(0, (unsigned long)_isr0, 0x08, 0x8E);
	idt_set_gate(1, (unsigned long)_isr1, 0x08, 0x8E);
	idt_set_gate(2, (unsigned long)_isr2, 0x08, 0x8E);
	idt_set_gate(3, (unsigned long)_isr3, 0x08, 0x8E);
	idt_set_gate(4, (unsigned long)_isr4, 0x08, 0x8E);
	idt_set_gate(5, (unsigned long)_isr5, 0x08, 0x8E);
	idt_set_gate(6, (unsigned long)_isr6, 0x08, 0x8E);
	idt_set_gate(7, (unsigned long)_isr7, 0x08, 0x8E);
	idt_set_gate(8, (unsigned long)_isr8, 0x08, 0x8E);
	idt_set_gate(9, (unsigned long)_isr9, 0x08, 0x8E);
	idt_set_gate(10, (unsigned long)_isr10, 0x08, 0x8E);
	idt_set_gate(11, (unsigned long)_isr11, 0x08, 0x8E);
	idt_set_gate(12, (unsigned long)_isr12, 0x08, 0x8E);
	idt_set_gate(13, (unsigned long)_isr13, 0x08, 0x8E);
	idt_set_gate(14, (unsigned long)_isr14, 0x08, 0x8E);
	idt_set_gate(15, (unsigned long)_isr15, 0x08, 0x8E);
	idt_set_gate(16, (unsigned long)_isr16, 0x08, 0x8E);
	idt_set_gate(17, (unsigned long)_isr17, 0x08, 0x8E);
	idt_set_gate(18, (unsigned long)_isr18, 0x08, 0x8E);
	idt_set_gate(19, (unsigned long)_isr19, 0x08, 0x8E);
	idt_set_gate(20, (unsigned long)_isr20, 0x08, 0x8E);
	idt_set_gate(21, (unsigned long)_isr21, 0x08, 0x8E);
	idt_set_gate(22, (unsigned long)_isr22, 0x08, 0x8E);
	idt_set_gate(23, (unsigned long)_isr23, 0x08, 0x8E);
	idt_set_gate(24, (unsigned long)_isr24, 0x08, 0x8E);
	idt_set_gate(25, (unsigned long)_isr25, 0x08, 0x8E);
	idt_set_gate(26, (unsigned long)_isr26, 0x08, 0x8E);
	idt_set_gate(27, (unsigned long)_isr27, 0x08, 0x8E);
	idt_set_gate(28, (unsigned long)_isr28, 0x08, 0x8E);
	idt_set_gate(29, (unsigned long)_isr29, 0x08, 0x8E);
	idt_set_gate(30, (unsigned long)_isr30, 0x08, 0x8E);
	idt_set_gate(31, (unsigned long)_isr31, 0x08, 0x8E);
}


void idt_set_gate(uint8_t num, uint32_t base, uint16_t sel, uint8_t flags)
{
	/* Split up the base */
	uint16_t base_hi = base >> 16;
	uint16_t base_lo = (base & 0x0000FFFF);

	/* Set the values of the IDT entry */
	idt[num].base_hi	= base_hi;
	idt[num].base_lo	= base_lo;
	idt[num].sel		= sel;
	idt[num].flags		= flags;
}

void idt_install()
{
	idtp.limit = (sizeof(struct idt_entry) * 256) - 1;
	idtp.base = (long)&idt;

	memset(idt, 0, sizeof(struct idt_entry) * 256);

	_idt_load();
}

void fault_handler(struct regs *r)
{
	/* Are we servicing an Intel Exception? */
	if (r->int_no < 32)
	{
		puts(_exception_messages[r->int_no]);
		puts(" Exception. System Halted!\n");

		for ( ;; );
	}
}

