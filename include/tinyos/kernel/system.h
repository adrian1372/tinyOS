#ifndef __TINYOS_SYSTEM_H__
#define __TINYOS_SYSTEM_H__

#include <tinyos/inttypes.h>

struct regs
{
	uint32_t gs, fs, es, ds;							/* Pushed the segs last */
	uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;	/* Pushed by pusha */
	uint32_t int_no, err_code;							/* Pushed by push bytes and ECODES */
	uint32_t eip, cs, eflags, useresp, ss;				/* Pushed by the processor */
};

/*
 * Fault Handler to handle Exceptions.
 * Pointed to by Interrupt Service Routines defined in the IDT
 */
void fault_handler(struct regs *r);

/*
 * Handler for Interrupt Requests (IRQ).
 */
void irq_handler(struct regs *r);

#endif
