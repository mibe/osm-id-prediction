#!/bin/bash

URL=state.txt

if [ "$BASE_URL" == "" ]
then
	URL=http://planet.osm.org/replication/day/$URL
else
	URL=$BASE_URL/$URL
fi

lynx -dump $URL | grep -Eo '=[0-9]{3}$' | cut -c 2-
