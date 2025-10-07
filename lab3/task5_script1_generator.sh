#!/bin/bash

mkfifo pipe 2>/dev/null

while read -r line; do
	echo "$line" > pipe
	[[ "$line" == "QUIT" ]] && exit
done
