#!/bin/bash
############################

# default temp dir
TEMP_FILE=~/.cache/shellreturn.tmp
SHELL_COMMAND=""

############################

cd $PWD
#echo Script parm 1 is $1
case $1 in 
##################################
# 使用命令结果 return_pop
	"-p" )
		RET=`cat $TEMP_FILE`
		IS_IN_IF=0
		shift

		while ! [ -z $1 ]
		do
			if [ $1 == "," ]; then
				#echo if
				SHELL_COMMAND="$SHELL_COMMAND $RET"
				IS_IN_IF=1
			else
				#echo else
				SHELL_COMMAND="$SHELL_COMMAND $1"
			fi
			shift
		done

		[ $IS_IN_IF -eq 0 ] && SHELL_COMMAND="$SHELL_COMMAND $RET"

		$SHELL_COMMAND
		echo $SHELL_COMMAND

		;;

##################################
# 使用命令结果 return_save
	"-s" )
		shift

		while ! [ -z $1 ]
		do
			SHELL_COMMAND="$SHELL_COMMAND $1"
			shift
		done

		#echo $SHELL_COMMAND
		`$SHELL_COMMAND 1>$TEMP_FILE`
		[ $? -ne 0 ] && exit

		echo "-----------------------------------------------------------------"
		cat $TEMP_FILE 
		echo "-----------------------------------------------------------------"
		echo "(The above result have been cached.)"
		;;

	* )
		echo "Parm error!" 
		;;
esac

