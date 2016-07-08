#!/bin/bash

_TARGET_PRODUCT="android_x86"
_TARGET_BUILD_VARIANT="userdebug"
TARGET="$_TARGET_PRODUCT-$_TARGET_BUILD_VARIANT"
echo $TARGET

source ./build/envsetup.sh
lunch $TARGET

cpusb $OUT/android_x86.iso $1 
