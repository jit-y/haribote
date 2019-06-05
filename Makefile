DEST_DIR = dest

.PHONY: run dest
run: $(DEST_DIR)/haribote.img
	qemu-system-i386 -fda $^

clean:
	rm -rf dest

$(DEST_DIR)/haribote.img: $(DEST_DIR)/ipl.bin $(DEST_DIR)/haribote.sys
	echo $(DEST_DIR)/haribote.sys > $(DEST_DIR)/haribote.name
	dd if=$(DEST_DIR)/ipl.bin of=$(DEST_DIR)/haribote.img count=2880 bs=512 conv=notrunc
	dd if=$(DEST_DIR)/haribote.name of=$(DEST_DIR)/haribote.img count=1 bs=512 seek=19 conv=notrunc
	dd if=$(DEST_DIR)/haribote.sys of=$(DEST_DIR)/haribote.img count=1 bs=512 seek=33 conv=notrunc

$(DEST_DIR)/ipl.bin: lpl.asm
	nasm -o $@ $^

$(DEST_DIR)/haribote.sys: lpl.asm
	nasm $^ -o $@ -l $(DEST_DIR)/haribote.lst
