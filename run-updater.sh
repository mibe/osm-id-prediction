#!/bin/bash

if [ ! -e "last-sequence" ]
then
	echo "0" > last-sequence
fi

LAST_SEQ=$(cat last-sequence)
CURR_SEQ=$(./get-latest-sequence.sh)

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
	# Replication sequences are one-based.
	let COUNTER=COUNTER+1

	echo "$COUNTER - Downloading replication sequence..."
	./download-sequence.sh $COUNTER
	echo "$COUNTER - Done downloading - detectig highest element ID..."
	./update-db.sh $COUNTER
	echo "$COUNTER - Done."
done

echo "--- DONE ---"
