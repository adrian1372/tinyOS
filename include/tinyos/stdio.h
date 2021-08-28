/*
 * Standard I/O functions for tinyOS
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

#ifndef __TINYOS_STDIO_H__
#define __TINYOS_STDIO_H__




/* Global constants */
/* VGA Constants */
#define _VGA_LINE_LENGTH (80)
#define _VGA_START (0xB8000)

/* SPECIAL CHARACTERS */
#define _CHAR_NEWLINE (0x0A)

/* COLOR CODES */
#define _COLOR_BLACK			0x00
#define _COLOR_BLUE				0x01
#define _COLOR_GREEN			0x02
#define _COLOR_CYAN				0x03
#define _COLOR_RED				0x04
#define _COLOR_MAGENTA			0x05
#define _COLOR_BROWN			0x06
#define _COLOR_LIGHT_GREY		0x07
#define _COLOR_DARK_GREY		0x08
#define _COLOR_LIGHT_BLUE		0x09
#define _COLOR_LIGHT_GREEN		0x0A
#define _COLOR_LIGHT_CYAN		0x0B
#define _COLOR_LIGHT_RED		0x0C
#define _COLOR_LIGHT_MAGENTA	0x0D
#define _COLOR_LIGHT_BROWN		0x0E
#define _COLOR_WHITE			0x0F

/* Internal global variables */
//static volatile short *_vga_cursor = (short *)0xB000;

/*
 * Prints msg on the 1st line of the screen
 */
void printHello(const char *msg, int len, char colour);

/*
 * Prints the given null-terminated string to screen, starting at
 * current _vga_cursor position
 */
int puts(const char *_s);

/*
 * Prints the given character to screen at the current _vga_cursor position,
 * using the background and foreground colors given
 */
int putc(char _c, char _backcolor, char _forecolor);

#endif
