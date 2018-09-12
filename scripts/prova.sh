#!/bin/sh

BOARD="roadrunner"
LINUX="4.14.69"
DEBIAN="stretch"
DEFCONFIG="acme-roadrunner_defconfig"
DTS="acme-roadrunner-bertad2"
DTS_TARGET="acme-roadrunner"

echo " Board: [$BOARD]"
echo " Linux: [$LINUX]"
echo "Debian: [$DEBIAN]"

TARGET_DIR=$BOARD"_"$LINUX
echo "Target: [$TARGET_DIR]"

if [ ! -d "$TARGET_DIR" ]
then
	mkdir $TARGET_DIR
fi

if [ ! -f "$TARGET_DIR/linux-$LINUX.tar.xz" ]
then
	(cd $TARGET_DIR && wget https://www.kernel.org/pub/linux/kernel/v4.x/linux-$LINUX.tar.xz)
fi	

(cd $TARGET_DIR && tar xvfJ linux-$LINUX.tar.xz)


# Copy the requested defconfig and device tree files 
cp $DEFCONFIG $TARGET_DIR/linux-$LINUX/arch/arm/configs/
cp $DTS.dts $TARGET_DIR/linux-$LINUX/arch/arm/boot/dts

# Configure Linux
(cd $TARGET_DIR/linux-$LINUX && make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- $DEFCONFIG)

# Compile the dts
(cd $TARGET_DIR/linux-$LINUX && make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- $DTS.dtb)

# Compile the Linux zImage
(cd $TARGET_DIR/linux-$LINUX && make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage)

# Compile the Kernel modules
(cd $TARGET_DIR/linux-$LINUX && make modules -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-)
(cd $TARGET_DIR/linux-$LINUX && make modules_install INSTALL_MOD_PATH=./modules ARCH=arm)

# Move the binary file on http://builder.acmesystems.it:

cp $TARGET_DIR/linux-$LINUX/arch/arm/boot/dts/$DTS.dtb $TARGET_DIR/$DTS_TARGET.dtb
cp $TARGET_DIR/linux-$LINUX/arch/arm/boot/zImage $TARGET_DIR
tar -cvjf $TARGET_DIR/modules.tar.bz2 -C $TARGET_DIR/linux-$LINUX/modules .

#tar -xvjpf modules.tar.bz2 -C /lib 