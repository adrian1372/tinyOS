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

INCLUDE=include

# target ... : prerequisites ...
# 			command to generate target
# 

# 1. create a all-zero file with blocksize=512 and 1440KB
# 2. write boot.bin into the file skip 0 (seek attribute) blocks
# you need to install i386-elf-g++ by
#		brew install --debug i386-elf-gcc
myos.img : kernel.bin
	dd if=/dev/zero of=myos.img bs=512 count=2880 &&\
	dd if=kernel.bin of=myos.img seek=0 conv=notrunc

boot.o : main.asm
#	nasm -f elf32 loader.asm -o loader.o
	nasm -f elf32 main.asm -o boot.o

kernel.bin : boot.o main.c stdio.c 
	$(CC) -m32 stdio.c main.c boot.o \
		-o kernel.bin \
		$(CFLAGS) $(CWARN) \
		-I$(INCLUDE) -T $(LINKER)

		#-nostdlib -ffreestanding -std=c99 -mno-red-zone -nostdlib -Wall -Wextra -Werror \
		#-Iinclude -T linker.ld



run : myos.img
	qemu-system-x86_64 -fda myos.img

.PHONY : clean # .PHONY means clean is not a file or an object
clean: 
	rm *.bin *.img *.o
