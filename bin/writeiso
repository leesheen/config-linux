#!/bin/bash

#echo $ANDROID_PRODUCT_OUT
#echo $TARGET_PRODUCT

[ -z $1 ] && echo "usage: " && echo "     writeiso /dev/sdb" && exit 1

DEVNAME=`basename $1 | cut -c 1-3`

case $DEVNAME in
	sda )
		echo "DANGER!!!!!"
		exit 1
		;;
	sd* )
		DDADDR="/dev/$DEVNAME"
		;;
	* )
		echo "Check!!!!!"
		;;
esac

lsblk | grep $DEVNAME > /dev/null
[ $? -ne 0 ] && echo "No \"$DDADDR\" " && exit 1

( [ -z $ANDROID_PRODUCT_OUT ] || [ -z $TARGET_PRODUCT ] ) \
	&& echo "No lunch." && exit 1

ISOADDR=$ANDROID_PRODUCT_OUT/$TARGET_PRODUCT.iso

echo "" && echo "***********************************************" 
echo "" && echo "ISO: $ISOADDR" 
echo "" && echo "DEV: "$DDADDR"" 
echo "" && lsblk -n -o NAME,SIZE,LABEL $DDADDR
echo "" && echo "***********************************************" 

read -n1 -p "ARE YOU SURE? (y/n): "

case $REPLY in

	"y" | "Y" | "yes" | "YES" )
		sudo dd if=$ISOADDR of=$DDADDR 
		echo "" && echo "dd OK."
		exit $?
		;;
	"n" | "N" | "no" | "NO" )
		echo ""
		exit 1
		;;
	* )
		echo "" && echo "Enter Error!"
		exit 1
		;;
esac
