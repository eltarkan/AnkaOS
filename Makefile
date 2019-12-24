GCCPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
ASPARAMS = --32
LDPARAMS = -melf_i386

objects = loader.o kernel.o

%.o: %.cpp
	gcc $(GCCPARAMS) -c -o $@ $<
	
%.o: %.s
	as $(ASPARAMS)  -o $@ $<
	
ankateam.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)
	
ankateam.iso: ankateam.bin
	mkdir iso
	mkdir iso/boot
	mkdir iso/boot/grub
	
	cp $< iso/boot/
	echo 'set timeout = 0' > iso/boot/grub/grub.cfg
	echo 'set default=0' >>	iso/boot/grub/grub.cfg
	echo '' >> iso/boot/grub/grub.cfg
	echo 'menuentry "ANKA TEAM" {' >> iso/boot/grub/grub.cfg
	echo 'multiboot /boot/ankateam.bin' >> iso/boot/grub/grub.cfg
	echo 'boot' >> iso/boot/grub/grub.cfg
	echo '}' >> iso/boot/grub/grub.cfg
	grub-mkrescue --output=ankateam.iso iso
	rm -rf iso
	
		
install:ankateam.bin
	sudo cp $< /boot/ankateam.bin
	
