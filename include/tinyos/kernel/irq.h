#ifndef __TINYOS_IRQ_H__
#define __TINYOS_IRQ_H__

#include <tinyos/kernel/system.h>

/* Installs a custom IRQ handler for a given IRQ */
void irq_install_handler(int irq, void (*handler)(struct regs *r));

/* Uninstalls an IRQ handler for a given IRQ */
void irq_uninstall_handler(int irq);

/*
 * Remaps the IRQs 0-7 from ISR 8-15 to 32-39
 * Avoids IRQs 0-7 from clashing with Intel Exceptions
 */
void irq_remap(void);

/*
 * Install the Default IRQ handlers
 */
void irq_install(void);

#endif
