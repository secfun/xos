# the follow command not found and can be replaced with as, ld, objcopy
AS=as
LD=ld
OBJCOPY=objcopy
QEMU=qemu-system-i386

LDFLAGS	+= -Ttext 0

.PHONY=clean run all

all: bootsect
test:
	echo $(PWD)
	echo $(CURDIR)
	echo $(CURDIR)/obj/bootloader.o

prepare_dir:
	mkdir obj
	mkdir bin

bootloader.bin:prepare_dir boot/bootloader.s
	# 对汇编代码进行编译
	$(AS) -o obj/bootloader.o boot/bootloader.s
	# 对编译结果进行链接, -Ttext 0从text段的0地址地方链接
	$(LD) $(LDFLAGS) -o obj/bootloader obj/bootloader.o
	# remove section name
	# objcopy -S 移除所有的标识以及重定位信息
	# -O 表示输出的格式
	$(OBJCOPY) -R .pdr -R .comment -R.note -S -O binary obj/bootloader bin/bootloader.bin

kernel.bin: kernel/kernel.s
	$(AS) -n -g -o obj/kernel.o kernel/kernel.s
	$(LD) $(LDFLAGS) -o obj/kernel obj/kernel.o
	$(OBJCOPY) -R .pdr -R .comment -R.note -S -O binary obj/kernel bin/kernel.bin

bootimg: bootloader.bin kernel.bin
	dd if=bin/bootloader.bin of=bin/bootimg bs=512 count=1
	dd if=bin/kernel.bin of=bin/bootimg bs=512 count=4 seek=1
	echo "Build bootimg done"

run:clean bootimg
	$(QEMU) -boot a -fda bin/bootimg
debug:clean bootimg
	$(QEMU) -s -S -boot a -fda bin/bootimg
gdb:
	gdb -q -x tools/gdbinit

clean:
	#rm -f bootloader.o bootloader bootloader.bin bootimg kernel kernel.bin kernel.o
	rm -rf bin
	rm -rf obj
