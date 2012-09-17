#!/bin/bash

# Tool to rename .osc.gz and .state.txt files into 9 digit sequence number format.

# Usage:
# rename_3_to_9.sh [DIR] [PADDING]

# Defaults
PADDING="000000"
DIR="."

if [ "$1" != "" ]
then
	if [ -d $1 ]
	then
		DIR=$1
	else		
		PADDING=$1
	fi
fi

if [ "$2" != "" ]
then
	if [ -d $2 ]
	then
		DIR=$2
	else
		PADDING=$2
	fi
fi

# Check if padding is 6 digits long
if [ "${#PADDING}" -ne 6 ]
then
	echo "Padding argument not six digits long."
	exit 1
fi

# Core rename function
#
# 1 = File extension
rename()
{
	for a in *.$1
	do
		if [ -f $a ]
		then
			FILE=$(basename $a .$1)
			
			if [ "${#FILE}" -ne 9 ]
			then
				mv $a $PADDING$FILE.$1
				echo "Renamed $a."
			fi
			
		else
			echo "No files with pattern '*.$1' found."
			break
		fi
	done
}

# Change to choosen path
PWD=$(pwd)
cd $DIR

rename "osc.gz"
rename "state.txt"

cd $PWD
