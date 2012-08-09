#!/bin/bash

zcat $1 | grep "$2" | grep -Po ' id="\K.*?(?=")' | sort -rn | head -n 1
