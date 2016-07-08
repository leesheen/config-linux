#!/bin/bash

_TARGET_PRODUCT="android_x86"
_TARGET_BUILD_VARIANT="userdebug"

echo $1
while ! [ -z $1 ]
do
	case $1 in
		"32" )
			_TARGET_PRODUCT="android_x86" 
			;;
		"64" )
			_TARGET_PRODUCT="android_x86_64" 
			;;
		"user" | "userdeug" | "eng" )
			_TARGET_BUILD_VARIANT="$1"
			;;
		"clean" )
			_NEED_CLEAN=clean
			;;
		* )
			;;
	esac

	shift
done

TARGET="$_TARGET_PRODUCT-$_TARGET_BUILD_VARIANT"
echo $TARGET

source ./build/envsetup.sh
lunch $TARGET
make -C kernel O=$OUT/obj/kernel ARCH=x86 menuconfig

