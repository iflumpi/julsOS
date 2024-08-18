# julsOS 

This is a simple operating system designed for learning purposes. It is a 16-bit OS that uses BIOS interruptions in real mode and does not implement the transition to protected mode.

Please note that this operating system is still very basic and not useful at all. It is designed for learning purposes and to provide a hands-on experience with low-level programming concepts.


## Features

- Bootloader
- Basic input/output functionality
- Simple command line interface
- Basic file system (only supports files, no folders)
- Basic process management


## Requirements

To run this operating system, you will need the following:

- A computer with a 16/32-bit processor supporting MBR.
- A bootable medium (e.g., floppy disk, USB drive) to load the OS

or

- qemu-system-i386 package to load the OS from another machine


### Building

1. Clone the repository:

    ```bash
    git clone https://codeberg.org/iflumpi/julsOS.git
    cd julsOS
    ```

2. Build the project:

    ```bash
    make
    ```

3. After building, you will find the binary file with bootloader and kernel (`boot.bin`) in the `build` directory.


## Installation

### QEMU

1. Execute qemu with bootloader and kernel as bootable.

    ```bash
    qemu-system-i386 -fda build/boot.bin -boot a
    ```


### Real hardware

1. Write the bootloader and kernel (`boot.bin`) to the first sectors of a device like a floppy or usb (e.g., /dev/sdc). 

    ```bash
    dd if=build/boot.bin of=/dev/sdc status=progress 
    ```

2. Insert the bootable medium into your computer and restart it.


## Usage

Once the operating system is booted, you will be presented with a command line interface. From here, you can execute various commands and interact with the system.

The only supported command in the current version is `ls`, to list the available files in the system. These files can be added statically with the script _src/asm/scripts/addfiles.sh_. It is possible to execute any of these files. They shall be implemented to use real mode and BIOS interruptions.


### Examples

There are some examples of packages in the _examples_ folder. They can be built by entering in the specific folder and execute#:

    ```bash
        .\build.sh
    ```

## License

This project is licensed under the [MIT License](LICENSE). Feel free to use, modify, and distribute this code as per the terms of the license.
