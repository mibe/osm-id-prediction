#!/bin/bash

URL=http://planet.osm.org/redaction-period/day-replicate/state.txt

lynx -dump $URL | grep -Eo '=[0-9]{3}$' | cut -c 2-
