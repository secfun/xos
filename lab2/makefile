# the follow command not found and can be replaced with as, ld, objcopy
AS=as
LD=ld
OBJCOPY=objcopy
QEMU=qemu-system-i386

LDFLAGS	+= -Ttext 0

.PHONY=clean run all

all: bootsect

bootloader.bin: bootloader.s
	# 对汇编代码进行编译
	$(AS) -o bootloader.o bootloader.s
	# 对编译结果进行链接, -Ttext 0从text段的0地址地方链接
	$(LD) $(LDFLAGS) -o bootloader bootloader.o
	# remove section name
	# objcopy -S 移除所有的标识以及重定位信息
	# -O 表示输出的格式
	$(OBJCOPY) -R .pdr -R .comment -R.note -S -O binary bootloader bootloader.bin

kernel.bin: kernel.s
	$(AS) -n -g -o kernel.o kernel.s
	$(LD) $(LDFLAGS) -o kernel kernel.o
	$(OBJCOPY) -R .pdr -R .comment -R.note -S -O binary kernel kernel.bin

bootimg:kernel.bin bootloader.bin
	dd if=bootloader.bin of=bootimg bs=512 count=1
	dd if=kernel.bin of=bootimg bs=512 count=4 seek=1
	echo "Build bootimg done"

run:clean bootimg
	$(QEMU) -boot a -fda bootimg
debug:clean bootimg
	$(QEMU) -s -S -boot a -fda bootimg

clean:
	rm -f bootloader.o bootloader bootloader.bin bootimg kernel kernel.bin kernel.o
