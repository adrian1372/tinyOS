/*
 * Entry point of C portion of tinyOS
 *
 * Based on the work of Yu Wang <wangy52@rpi.edu>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 */

#include <tinyos/kernel/system.h>
#include <tinyos/kernel/idt.h>
#include <tinyos/kernel/irq.h>
#include <tinyos/stdio.h>

int main()
{
	const char *string = "Hello World!!\ndasdasd";

	/* Install the IDT, ISRS, IRQ and finally allow IRQs to happen */
	idt_install();
	isrs_install();
	irq_install();
	__asm__ volatile ("sti");

	puts(string);

	return 0; // Return to ASM code
}
