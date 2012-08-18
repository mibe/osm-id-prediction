#!/bin/bash

# File, in which the latest processed sequence number is saved
SEQ_FILE="last-sequence"

# Initialize file with last sequence number if it's not existing
if [ ! -e "$SEQ_FILE" ]
then
	echo "0" > $SEQ_FILE
fi

LAST_SEQ=$(cat $SEQ_FILE)
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

	if [ "$NO_DL" == "" ]
	then
		echo "$COUNTER - Downloading replication files..."
		./download-sequence.sh $COUNTER
	fi

	echo "$COUNTER - Ddetectig highest element ID and population database..."
	./update-db.sh $COUNTER
	echo "$COUNTER - Done."
	
	# Save latest processed sequence already here
	echo $COUNTER > $SEQ_FILE
done

echo "--- DONE ---"
