## OS_Developement

My plan for this is to write an operating system completely from scratch.  While I could use GRUB as my bootloader, I am writing my own bootloader that goes through the necessary measures to get into long mode and load the kernel.  The kernel is completely up in the air.  Since this is a new learning experience for me, I am unsure how far I want to take the kernel.

### Table of Contents
1. [Implementation](#implementation)
2. [Contributing](#contributing)
3. [License](#license)

### Implementation

#### Dependencies

To compile assembly files, create ISO, compile C files, burn ISO image to a CD/DVD, and test code, you will need the following packages (for Arch Linux - if you're on Debian, you will have to find the proper equivilents):

* nasm
* cdrtools
* gcc (you should have this, but for completeness, I am including it here)
* dvd+rw-tools
* qemu (or bochs - the makefile uses qemu, so you will have to change it if you choose to use bochs)
* virtualbox (optional)

#### Installation

For the bootloader:

To compile, just run the makefile `make`
To create an ISO, run `make iso`

If you want to run the ISO as a VM, create a new Windows VM in VirtualBox with all defaults, and in the storage settings menu, select the CD icon which should say "Empty" next to it, check the "Live CD" option, and choose your ISO image.

To burn the ISO to a CD:

```
growisofs -dvd-compat -Z /dev/<optical drive>=<ISO image>
```

To find your optical drive, use the command `lsblk -f`.  Typically, it will be sr0 (/dev/sr0).  Make sure that the optical drive is unmounted before burning (`umount -R /dev/sr0`)

#### Usage

This would be used as an operating system which could be on any form of media.  There isn't likely going to be any practical application for this project.

**[Return to top](#table-of-contents)**

### Contributing

Please open an issue to talk about changes or additions.  Since I am doing this as a self-enrichment project, I am not looking for a lot of community input at the moment.

**[Return to top](#table-of-contents)**

### License

View license information [here](https://github.com/theMike97/OS_Developement/blob/master/LICENSE) 

**[Return to top](#table-of-contents)**
