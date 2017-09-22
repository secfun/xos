# the follow command not found and can be replaced with as, ld, objcopy
#AS=i686-elf-as
#OBJCOPY=i686-elf-objcopy
#LD=i686-elf-ld
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

run: bootloader.bin
	$(QEMU) -boot a -fda bootloader.bin
rundebug: bootloader.bin
	$(QEMU) -boot a -fda bootloader.bin

clean:
	rm -f bootloader.o bootloader bootloader.bin
