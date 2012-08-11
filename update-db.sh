#!/bin/bash

if [ ! -e "last-sequence" ]
then
	echo "0" > last-sequence
fi

LAST_SEQ=$(cat last-sequence)
CURR_SEQ=$(exec ./get-latest-sequence.sh)

echo "Latest sequence in database: $LAST_SEQ"
echo "Current sequence on server: $CURR_SEQ"

if [ $LAST_SEQ -eq $CURR_SEQ ]
then
	echo "Already up-to-date, nothing to do here."
	exit
fi

COUNTER=$LAST_SEQ

while [ $COUNTER -lt $CURR_SEQ ]
do
	let COUNTER=COUNTER+1

done
