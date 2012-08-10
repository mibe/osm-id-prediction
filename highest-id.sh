#!/bin/bash

if [ ! $# -eq 1 ]
then
	echo "Missing argument: highest-id.sh <OsmChange file>"
	exit
fi

if [ ! -r $1 ]
then
	echo "File not found or not readable."
	exit
fi

zcat $1 | grep "<$2" | grep -Po ' id="\K.*?(?=")' | sort -rn | head -n 1
