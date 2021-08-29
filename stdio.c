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


#include <tinyos/stdio.h>
#include <tinyos/inttypes.h>
#include <tinyos/kernel/hw.h>

/* ========= START OF INTERNAL SECTION ========= */

static volatile short *_vga_cursor = (short *)_VGA_START;

static inline int32_t _get_relative_address()
{
	return (long)_vga_cursor - _VGA_START;
}

/*
 * Function to "print a newline character".
 * Internally, this function calculates how many more characters can fit in current line
 * and moves _vga_cursor forward by that many places.
 */
void __put_newline()
{
	long address = (long)_vga_cursor;
	long relativeaddress = address - _VGA_START; // Can't assume VGA memory starts at address div. by linelen
	int remainder = relativeaddress % (_VGA_LINE_LENGTH << 1);

	_vga_cursor += (_VGA_LINE_LENGTH - (remainder >> 1));
}

/*
 * putc variant for internal use
 * only difference is that this does NOT move the visual cursor
 * after a character is written, to optimize string output
 */
int _putc(char _c, char _backcolor, char _forecolor)
{
	char color = _backcolor << 4 | _forecolor;
	*_vga_cursor = (color << 8) | _c;
	_vga_cursor++;
	return 0;
}

uint16_t _get_cursor_position(void)
{
	uint16_t pos = 0;

	outb(0x3D4, 0x0F);
	pos |= inb(0x3D5);
	outb(0x3D4, 0x0E);
	pos |= ((uint16_t)inb(0x3D5)) << 8;
	return pos;
}

void _update_cursor(uint16_t pos)
{
	outb(0x3D4, 0x0F);
	outb(0x3D5, (uint8_t)(pos & 0xFF));
	outb(0x3D4, 0x0E);
	outb(0x3D5, (uint8_t)((pos >> 8) & 0xFF));
}


/* ========== END OF INTERNAL SECTION ========== */



void printHello(const char *msg, int len, char colour)
{
	short *vga = (short *)0xB000;
	short textoffset = 0;
	for (int i = 0; i < len; i++)
	{
		vga[i + textoffset] = colour | msg[i];
	}
}

int puts(const char *_s)
{
	int ret = 0;
	int count = 0;
	const char *ptr = _s;
	while (*ptr > 0)
	{
		switch (*ptr)
		{
			case _CHAR_NEWLINE:
				__put_newline();
				break;
			default:
				ret = _putc(*ptr, _COLOR_BLACK, _COLOR_WHITE);
				if (!ret) count++;
				break;	
		}
		ptr++;
	}
	/* TODO: Move the visual cursor */
	_update_cursor(_get_relative_address() >> 1);

	return count;
}

int putc(char _c, char _backcolor, char _forecolor)
{
	char color = _backcolor << 4 | _forecolor;
	*_vga_cursor = (color << 8) | _c;
	_vga_cursor++;

	/* TODO: Move the visual cursor */
	_update_cursor((_get_relative_address() >> 1));
	return 0;
}

