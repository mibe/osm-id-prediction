#!/bin/bash

if [ ! $# -eq 1 ]
then
	echo "Missing argument: download-sequence.sh <sequence number>"
        exit
fi

# Padding of sequence number e.g. 123 --> 000000123
PAD_SEQ=$(printf "%09d" $1)

if [ "$BASE_URL" == "" ]
then
	BASE_URL=http://planet.osm.org/redaction-period/day-replicate
fi

# Build URLs to download
FIRST=$(echo $PAD_SEQ | cut -c 1-3)
SECOND=$(echo $PAD_SEQ | cut -c 4-6)
THIRD=$(echo $PAD_SEQ | cut -c 7-9)
URL=$BASE_URL/$FIRST/$SECOND/$THIRD
OSC_URL=$URL.osc.gz
STATE_URL=$URL.state.txt

# Core download function
#
# 1 = URL to download
download ()
{
	# Generate filename from full padded sequence number
	EXTENSION=$(echo $1 | grep -Eo '[a-z]+\.[a-z]+$')
	FILE=$PAD_SEQ.$EXTENSION

	# Delete file if existing	
	if [ -e $FILE ]
		then rm $FILE
	fi
	
	curl --progress-bar -f -o $FILE $1
}

download $OSC_URL
download $STATE_URL
