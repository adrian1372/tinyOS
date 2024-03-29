 ################################################################################
 #																				#
 # Based on the work of Yu Wang <wangy52@rpi.edu>								#
 #																				#
 # This program is free software: you can redistribute it and/or modify			#
 # it under the terms of the GNU General Public License as published by			#
 # the Free Software Foundation, either version 3 of the License, or			#
 # (at your option) any later version.											#
 #																				#
 # This program is distributed in the hope that it will be useful,				#
 # but WITHOUT ANY WARRANTY; without even the implied warranty of				#
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the				#
 # GNU General Public License for more details.									#
 #																				#
 # You should have received a copy of the GNU General Public License			#
 # along with this program.  If not, see <https://www.gnu.org/licenses/>.		#
 #																				#
 ################################################################################

CC=i686-elf-gcc
CFLAGS=-nostdlib -ffreestanding -std=c99 -mno-red-zone -nostdlib
CWARN=-Wall -Wextra -Werror
LINKER=linker.ld

OBJS-ASM=boot.o kernel_entry.o
OBJS-C=kernel.o stdio.c ps2kbd.o 

INCLUDE=include

myos.img : kernel.bin
	dd if=/dev/zero of=myos.img bs=512 count=2880 &&\
	dd if=kernel.bin of=myos.img seek=0 conv=notrunc

%.o : %.asm 
	nasm -f elf32 $< -o $@

%.o : %.c
	$(CC) -m32 -c $< -o $@ \
		$(CFLAGS) $(CWARN) \
		-I$(INCLUDE)

kernel.bin : $(OBJS-ASM) $(OBJS-C) 
	$(CC) -m32 $(OBJS-ASM) $(OBJS-C) \
		-o kernel.bin \
		$(CFLAGS) $(CWARN) \
		-I$(INCLUDE) -T $(LINKER)

run : myos.img
	qemu-system-x86_64 -fda myos.img

.PHONY : clean # .PHONY means clean is not a file or an object
clean: 
	rm *.bin *.img *.o
