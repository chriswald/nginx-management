#!/bin/bash
FILE=$1
if test -f $FILE; then
	cat $FILE | awk '/^[^#]/ { print $1 }' | sudo xargs -I {} ufw deny from {} to any
else
	echo "$FILE does not exist"
fi
