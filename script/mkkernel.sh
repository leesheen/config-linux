#!/bin/bash

########################################
# kernel output dir
OUT_DIR_NAME=kernel-out

########################################
# kernel need clean
NEED_CLEAN=""

########################################
# Choose kernel arch
KERNEL_ARCH=x86

echo $1
while ! [ -z $1 ]
do
	case $1 in
		"64" )
			KERNEL_ARCH=x86_64
			;;
		"clean" )
			NEED_CLEAN=clean
			;;
		* )
			;;
	esac

	shift
done

########################################

KERNEL_OUT=$PWD/../$OUT_DIR_NAME/$KERNEL_ARCH
KERNEL_TOOLCHAIN=/data/leesheen/workdir/phoenixOS/x86/marshmallow/beta/prebuilts/gcc/linux-x86/x86/x86_64-linux-android-4.9/bin/x86_64-linux-android-
KERNEL_CONFIG=android-"$KERNEL_ARCH"_defconfig

echo $KERNEL_OUT
echo $KERNEL_CONFIG

########################################

KERNEL_MAKE="make O=$KERNEL_OUT ARCH=x86 CROSS_COMPILE=$KERNEL_TOOLCHAIN"

[ -z $NEED_CLEAN ] || ( $KERNEL_MAKE clean && echo "make clean finish." )
$KERNEL_MAKE $KERNEL_CONFIG
$KERNEL_MAKE -j8

########################################
