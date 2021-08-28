# tinyOS
This is a small project to create a simple, bootable system.
Calling tinyOS an Operating System is a huge exaggeration - the only current planned feature is ability to take keyboard input and print output.

## Build
To build tinyOS, an i686-elf cross-compiler is required. GCC is recommended.
With i686-elf-gcc installed, simply run `make` to build the system.

## Run
The build process will create a bootable medium that can be run in your favorite virtualizer.
With QEMU installed, simply run `make run`
