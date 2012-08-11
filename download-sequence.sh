#!/bin/bash

if [ ! $# -eq 1 ]
then
	echo "Missing argument: download-sequence.sh <sequence number>"
        exit
fi

PAD_SEQ=$(printf "%03d" $1)

BASE_URL=http://planet.osm.org/redaction-period/day-replicate/000/000/
OSC_URL=$BASE_URL/$PAD_SEQ.osc.gz
STATE_URL=$BASE_URL/$PAD_SEQ.state.txt

download ()
{
	FILE=$(basename $1)

	# Delete file if existing	
	if [ -e $FILE ]
		then rm $FILE
	fi
	
	curl --progress-bar -o $FILE $1
}

download $OSC_URL
download $STATE_URL
