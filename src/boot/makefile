main.bin:main.asm readDisk.asm printf.asm printh.asm testA20.asm enableA20.asm checklm.asm gdt.asm
	nasm -fbin main.asm -o main.bin
	rm -rf ./iso

clean:
	rm main.bin
	rm -rf ./iso

run:
	qemu-system-x86_64 main.bin

iso:
	rm -rf ./iso
	mkdir iso
	truncate main.bin -s 1200k
	cp main.bin ./iso
	mkisofs -b main.bin -o ./iso/main.iso ./iso
