DEST_DIR = dest

.PHONY: run clean
run: $(DEST_DIR)/haribote.img
	qemu-system-i386 -fda $^

clean:
	rm -rf dest/*

$(DEST_DIR)/haribote.img: $(DEST_DIR)/ipl.bin $(DEST_DIR)/haribote.sys
	# -B Use boot sector stored in the given file
	# -C creates the disk image file to install the MS-DOS file system on it
	# -f Specifies the size of the DOS file system to format.
	#    1440   1440K, double-sided, 18 sectors per track, 80 cylinders (for 3 1/2 HD)
	# -i image file
	mformat -f 1440 -B $(DEST_DIR)/ipl.bin -C -i $(DEST_DIR)/haribote.img ::
	mcopy -i $(DEST_DIR)/haribote.img $(DEST_DIR)/haribote.sys ::

$(DEST_DIR)/ipl.bin: ipl.s
	nasm $^ -o $@ -l $(DEST_DIR)/ipl.lst

$(DEST_DIR)/haribote.sys: haribote.s
	nasm $^ -o $@ -l $(DEST_DIR)/haribote.lst
