#include <tinyos/kernel/irq.h>
#include <tinyos/kernel/system.h>
#include <tinyos/kernel/hw.h>
#include <tinyos/kernel/idt.h>

extern void _irq0();
extern void _irq1();
extern void _irq2();
extern void _irq3();
extern void _irq4();
extern void _irq5();
extern void _irq6();
extern void _irq7();
extern void _irq8();
extern void _irq9();
extern void _irq10();
extern void _irq11();
extern void _irq12();
extern void _irq13();
extern void _irq14();
extern void _irq15();

/*
 * Array of function pointers to IRQ-routines
 * Used to handle custom IRQ-handlers for given IRQs
 */
void *irq_routines[16] = 
{
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0
};

void irq_install_handler(int irq, void (*handler)(struct regs *r))
{
	irq_routines[irq] = handler;
}

void irq_uninstall_handler(int irq)
{
	irq_routines[irq] = 0;
}

void irq_remap(void)
{
	outb(0x20, 0x11);
	outb(0xA0, 0x11);
	outb(0x21, 0x20);
	outb(0xA1, 0x28);
	outb(0x21, 0x04);
	outb(0xA1, 0x02);
	outb(0x21, 0x01);
	outb(0xA1, 0x01);
	outb(0x21, 0x0);
	outb(0xA1, 0x0);
}

void irq_install(void)
{
	irq_remap();

	idt_set_gate(32, (unsigned long)_irq0, 0x08, 0x8E);
	idt_set_gate(33, (unsigned long)_irq1, 0x08, 0x8E);
	idt_set_gate(34, (unsigned long)_irq2, 0x08, 0x8E);
	idt_set_gate(35, (unsigned long)_irq3, 0x08, 0x8E);
	idt_set_gate(36, (unsigned long)_irq4, 0x08, 0x8E);
	idt_set_gate(37, (unsigned long)_irq5, 0x08, 0x8E);
	idt_set_gate(38, (unsigned long)_irq6, 0x08, 0x8E);
	idt_set_gate(39, (unsigned long)_irq7, 0x08, 0x8E);
	idt_set_gate(40, (unsigned long)_irq8, 0x08, 0x8E);
	idt_set_gate(41, (unsigned long)_irq9, 0x08, 0x8E);
	idt_set_gate(42, (unsigned long)_irq10, 0x08, 0x8E);
	idt_set_gate(43, (unsigned long)_irq11, 0x08, 0x8E);
	idt_set_gate(44, (unsigned long)_irq12, 0x08, 0x8E);
	idt_set_gate(45, (unsigned long)_irq13, 0x08, 0x8E);
	idt_set_gate(46, (unsigned long)_irq14, 0x08, 0x8E);
	idt_set_gate(47, (unsigned long)_irq15, 0x08, 0x8E);

}

void irq_handler(struct regs *r)
{
	void (*handler)(struct regs *r);

	/* If we have a custom IRQ handler, run it */
	handler = irq_routines[r->int_no - 32];
	if (handler)
		handler(r);

	/*
	 * If the IRQ that was handled came from the slave controller,
	 * we need to send an EOI to it
	 */
	if (r->int_no >= 40 && r->int_no <= 47)
		outb(0xA0, 0x20);

	/* Also send an EOI to the master controller */
	outb(0x20, 0x20);

}

