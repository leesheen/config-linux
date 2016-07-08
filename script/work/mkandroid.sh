#!/bin/bash

_TARGET_PRODUCT="android_x86"
_TARGET_BUILD_VARIANT="userdebug"
_NEED_CLEAN=""
_NEED_ZIP=""

i=1
while ! [ -z $1 ]
do
	echo Script parm $i is $1 
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
		"7z" )
			_NEED_ZIP=7z
			;;
		* )
			;;
	esac

	((i++))
	shift
done
echo && echo 

TARGET="$_TARGET_PRODUCT-$_TARGET_BUILD_VARIANT"
echo "Will build target is $TARGET !!!"

# 没有参数时编译最后不产生7z文件，加快速度，减少硬盘读写
if [ -z $_NEED_ZIP ]; then
	echo "DON'T Generate android_x86.7z !!!!"   

	SRCFILE=$ANDROID_BUILD_TOP/bootable/newinstaller/Android.mk
	BAKFILE=$ANDROID_BUILD_TOP/bootable/newinstaller/Android.mk.shell.bak
	FILEMODTIME=`stat -c %y $SRCFILE`

	cp $SRCFILE $BAKFILE

	# 将备份文件的时间戳设置与源文件一致
	touch -d "$FILEMODTIME" $BAKFILE

	# 删除7z打包命令，并改时间戳
	sed -i '/7za/d' $SRCFILE
	touch -d "$FILEMODTIME" $SRCFILE
fi

echo && echo

source ./build/envsetup.sh 
lunch $TARGET 1>/dev/null 2>&1

# make clean
[ -z $_NEED_CLEAN ] || make clean

make iso_img -j12

# 恢复Android.mk
rm $SRCFILE
mv $BAKFILE $SRCFILE
# END

# Timing
#TIME_START=`date +%s`
#TIME_END=`date +%s`

#TIME_MIN=$(( ($TIME_END - $TIME_START) / 60 ))
#TIME_SEC=$(( ($TIME_END - $TIME_START) % 60))
#
#echo "Use time: "$TIME_MIN"m "$TIME_SEC"s"


