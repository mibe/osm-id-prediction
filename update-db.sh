#!/bin/bash

if [ ! $# -eq 1 ]
then
        echo "Missing argument: update-db.sh <sequence number>"
        exit 1
fi

# Update the database file
#
# 1 = databse file
# 2 = date
# 3 = ID
function update_db_file ()
{
	DB=$1
	DATE=$2
	ID=$3
	
	# Check if date is already in database
	if grep -qs "$DATE" $DB
	then
		echo "entry for $DATE already in $DB"
	else
		echo $DATE,$ID > $DB
	fi
}

# Database files
NODE_DB=node.db
WAY_DB=way.db
RELATION_DB=relation.db

FILE=$(printf "%03d" $1)
OSC_FILE=$FILE.osc.gz
STATE_FILE=$FILE.state.txt

if [ ! -e $OSC_FILE ]
then
	echo "Missing change file for sequence $1.";
	exit 1
elif [ ! -e $STATE_FILE ]
then
	echo "Missing state file for sequence $1.";
	exit 1
fi

DATE=$(cat $STATE_FILE | grep -Eo '[0-9]{4}-[0-9]{2}-[0-9]{2}')

echo "$1 - Detected date: $DATE"

NODE_ID=$(exec ./highest-id.sh $OSC_FILE node)
WAY_ID=$(exec ./highest-id.sh $OSC_FILE way)
RELATION_ID=$(exec ./highest-id.sh $OSC_FILE relation)

echo "$1 - Highest ID's (node - way - relation): $NODE_ID - $WAY_ID - $RELATION_ID"

update_db_file $NODE_DB $DATE $NODE_ID
update_db_file $WAY_DB $DATE $WAY_ID
update_db_file $RELATION_DB $DATE $RELATION_ID

echo "$1 - Database updated."
