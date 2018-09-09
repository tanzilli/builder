#!/bin/sh

BOARD="roadrunner"
LINUX="4.14.68"
DEBIAN="stretch"
DEFCONFIG="acme-roadrunner_defconfig"
DTS="acme-roadrunner-bertad2"
DTS_TARGET="acme-roadrunner"

echo " Board: [$BOARD]"
echo " Linux: [$LINUX]"
echo "Debian: [$DEBIAN]"

if [ ! -d "$BOARD" ]
then
	mkdir $BOARD
fi

if [ ! -f "$BOARD/linux-$LINUX.tar.xz" ]
then
	(cd $BOARD && wget https://www.kernel.org/pub/linux/kernel/v4.x/linux-$LINUX.tar.xz)
fi	

(cd $BOARD && tar xvfJ linux-$LINUX.tar.xz)


# Copy the requeste defconfig and device tree files 
cp $DEFCONFIG $BOARD/linux-$LINUX/arch/arm/configs/
cp $DTS.dts $BOARD/linux-$LINUX/arch/arm/boot/dts

# Configure Linux
(cd $BOARD/linux-$LINUX && make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- $DEFCONFIG)

# Compile the dts
(cd $BOARD/linux-$LINUX && make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- $DTS.dtb)

# Compile the Linux zImage
(cd $BOARD/linux-$LINUX && make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage)

# Compile the Kernel modules
(cd $BOARD/linux-$LINUX && make modules -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-)
(cd $BOARD/linux-$LINUX && make modules_install INSTALL_MOD_PATH=./modules ARCH=arm)

if [ ! -d "$BOARD/target" ]
then
	mkdir $BOARD/target
	cp $BOARD/linux-$LINUX/arch/arm/boot/dts/$DTS.dtb $BOARD/target/acme-$DTS_TARGET.dtb
	cp $BOARD/linux-$LINUX/arch/arm/boot/zImage $BOARD/target
	#tar $BOARD/linux-LINUX/modules/lib root@[ip_address]:/lib/.
fi	
