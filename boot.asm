 ; ------------------------------------------------------------------------	;
 ;																			;
 ; Boot code of tinyOS														;
 ;																			;
 ; Based on the work of Yu Wang <wangy52@rpi.edu>							;
 ;																			;
 ; This program is free software: you can redistribute it and/or modify		;
 ; it under the terms of the GNU General Public License as published by		;
 ; the Free Software Foundation, either version 3 of the License, or		;
 ; (at your option) any later version.										;
 ;																			;
 ; This program is distributed in the hope that it will be useful,			;
 ; but WITHOUT ANY WARRANTY; without even the implied warranty of			;
 ; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the			;
 ; GNU General Public License for more details.								;
 ;																			;
 ; You should have received a copy of the GNU General Public License		;
 ; along with this program.  If not, see <https://www.gnu.org/licenses/>.	;
 ;																			;
 ; ------------------------------------------------------------------------ ;



section .boot			; Mark as boot section (for the linker)
[BITS 16]
global boot
; Linker will handle the ORG 0x7C00 part

; ---- START OF BOOT SECTOR ---- ;
_start:
	mov [diskno], dl
	
	; Enable A20 bit
	mov ax, 0x2401
	int 0x15

	; Set VGA mode to be normal mode (text)
	mov ax, 0x3
	int 0x10

read_disk:
	mov ah, 0x02			; Function number - Read sectors from drive
	mov al, 0x0A			; Read 10 sectors from disk
	mov ch, 0x00			; Read from cylinder 0
	mov cl, 0x02			; Read starting at cylinder 2
	mov dh, 0x00			; Read head 0
	mov dl, [diskno]		; Read from diskno (currently, same as boot disk)
	mov bx, enter_kernel	; Target code pointer, here the program
	int 0x13

; Do the actual steps to enter Protcted Mode
enter_pm:
	cli						; Disable all BIOS interrupts
	lgdt [GDT_Descriptor]	; Load the GDT

	; Set last bit of special register CR0 to 1 to finalize the switch to 32-bit protected mode
	mov eax, cr0
	or eax, 1
	mov cr0, eax

	; Set up the data segment pointers
	mov ax, DATA_SEG
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	; CPU has entered 32-bit protected mode!
	; Need to make a "far jump" to our 32-bit code segment
	jmp CODE_SEG:start_protected_mode

; Define the Global Descriptor Table
GDT_Start:
	; GDT must start with a null-desriptor, consisting of 8 null-bytes.
	null_descriptor:
		dd 0 ; 4 null-bytes
		dd 0

	; Defining a Code Segment Descriptor for the GDT. The segment has the following properties:
	; Base: 0 (32-bit)
	; Limit: 0xFFFFF (max value, 20-bit)
	; pres,priv,type	= 1001
	; Type flags		= 1010
	; Other flags		= 1100
	code_descriptor:
	dw 0xffff			; First 16 bits of the LIMIT
	dw 0				; First 16 bits of the BASE
	db 0				; Next 8 bits of the BASE (total 24)
	db 0b10011010		; pres, priv, type and Type flags
	db 0b11001111		; Other flags + limit (last 4 bits)
	db 0				; Last 8 bits of the BASE

	; Defining a Data Segment Descriptor for the GDT. The segment has the following properties:
	; Base: 0 (32-bit)
	; Limit: 0xFFFFF (max value, 20-bit)
	; ppt				= 1001
	; Type flags		= 1010
	; Other flags		= 1100
	data_descriptor:
	dw 0xffff			; First 16 bits of the LIMIT
	dw 0				; First 16 bits of the BASE
	db 0				; Next 8 bits of the BASE (total 24)
	db 0b10010010		; ppt and Type flags
	db 0b11001111		; Other flags + last 4 bits of LIMIT
	db 0				; Last 8 bits of the BASE

GDT_End:
GDT_Descriptor:
	dw GDT_End - GDT_Start - 1	; GDT Size
	dd GDT_Start				; GDT Start address

; Set constants for the offsets of the segments from the start of the GDT
CODE_SEG equ code_descriptor - GDT_Start
DATA_SEG equ data_descriptor - GDT_Start

diskno: db 0			; Store the diskno of boot disk (for reading)

times 510 - ($ - $$) db 0
dw 0xAA55

; ---- END OF BOOT SECTOR ---- ;

; Actual code for the program.
; From here on, code should be written for 32-bit protected mode.
; Printing will now have to be done via direct manipulation of video memory.
; In TEXT mode, Video Memory address starts at 0xB8000
; Write 2 adjacent bytes to print a character to screen;
;	- First byte: CHAR
;	- Second byte: COLOUR
enter_kernel:
[BITS 32]
start_protected_mode:
%include "kernel_entry.asm"

