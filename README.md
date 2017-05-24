## Welcome to OS Developement!

My plan for this is to write an operating system completely from scratch.  While I could use GRUB as my bootloader, I am writing my own bootloader that goes through the necessary measures to get into long mode and load the kernel.  The kernel is completely up in the air.  Since this is a new learning experience for me, I am unsure how far I want to take the kernel.

### Table of Contents
1. [Implementation](#implementation)
2. [Contributing](#contributing)
3. [License](#license)

### Implementation

#### Dependencies



#### Installation

For the bootloader:

To compile, just run the makefile 'make'
To burn to a cd, create an ISO and then burn:

```
truncate main.bin -s 1200k
mkisofs -b main.bin -o os.iso ./
cdrecord -v -sao dev=<optical drive (ex. /dev/sr0)> os.iso
```

make sure that the optical drive is unmounted.

#### Usage

This would be used as an operating system which could be on any form of media.  There isn't likely going to be any practical application for this project.

**[Return to top](#table-of-contents)**

### Contributing

Please open an issue to talk about changes or additions.  Since I am doing this as a self-enrichment project, I am not looking for a lot of community input at the moment.

**[Return to top](#table-of-contents)**

### License

View license information [here](https://github.com/theMike97/OS_Developement/blob/master/LICENSE) 

**[Return to top](#table-of-contents)**
