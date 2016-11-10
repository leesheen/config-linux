#!/bin/bash

PWD=`pwd`
RET=0
TIME=dir_`date +%s`
DIRNAME=$PWD/$TIME
CPSOURCEFILE=$1
COPY_ARGUMENT=""
USBDISKPART=$2

function mktempdir()
{
	mkdir $DIRNAME

	RET=$?
	if [ $RET -ne 0 ]; then
		echo "Create '$DIRNAME' Error ($RET), Please try again."
		exit 1
	fi

}

function rmtempdir()
{
	rm $DIRNAME -r

	RET=$?
	if [ $RET -ne 0 ]; then
		echo "Remove '$DIRNAME' Error ($RET), Please DELETE $DIRNAME by yourself."
		exit 1
	fi
}

function mountdir()
{
	sudo mount $USBDISKPART $DIRNAME 

	RET=$?
	if [ $RET -ne 0 ]; then
		echo "Mount '$USBDISKPART' Error ($RET)"
		rmtempdir
		exit 1
	fi
}

function umountdir()
{
	sudo umount $DIRNAME 

	RET=$?
	if [ $RET -ne 0 ]; then
		echo "Umount '$DIRNAME' Error ($RET), Please CHECK&DELETE $DIRNAME by yourself"
		exit 1
	fi
}


function copyfile()
{

	[ -d $CPSOURCEFILE ] && $COPY_ARGUMENT="-a" && echo hah

	sudo cp $COPY_ARGUMENT $CPSOURCEFILE $DIRNAME

	RET=$?
	if [ $RET -ne 0 ]; then
		echo "Copy '$USBDISKPART' Error ($RET)"
		umountdir
		rmtempdir
		exit 1
	fi

	ls -l $DIRNAME/
	sync
}

mktempdir
mountdir
copyfile
umountdir
rmtempdir
