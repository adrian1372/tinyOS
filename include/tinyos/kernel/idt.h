#ifndef __TINYOS_IDT_H__
#define __TINYOS_IDT_H__

#include <tinyos/inttypes.h>

struct idt_entry
{
	uint16_t base_lo;
	uint16_t sel;
	uint8_t always0;
	uint8_t flags;
	uint16_t base_hi;
} __attribute__((packed));

struct idt_ptr
{
	uint16_t limit;
	uint32_t base;
} __attribute__((packed));

/*
 * Loads the Interrupt Descriptor Table, defined in ASM
 */
extern void _idt_load();

/*
 * Sets an entry in the Interrupt Descriptor Table
 */
void idt_set_gate(uint8_t num, uint32_t base, uint16_t sel, uint8_t flags);

/*
 * Installs the Interrupt Descriptor Table
 */
void idt_install();

void isrs_install();

#endif
