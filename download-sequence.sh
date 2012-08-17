#!/bin/bash

if [ ! $# -eq 1 ]
then
	echo "Missing argument: download-sequence.sh <sequence number>"
        exit
fi

PAD_SEQ=$(printf "%03d" $1)

if [ "$BASE_URL" == "" ]
then
	BASE_URL=http://planet.osm.org/redaction-period/day-replicate/
fi

OSC_URL=$BASE_URL/000/000/$PAD_SEQ.osc.gz
STATE_URL=$BASE_URL/000/000/$PAD_SEQ.state.txt

download ()
{
	FILE=$(basename $1)

	# Delete file if existing	
	if [ -e $FILE ]
		then rm $FILE
	fi
	
	curl -C --progress-bar -o $FILE $1
}

download $OSC_URL
download $STATE_URL
