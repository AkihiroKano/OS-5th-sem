#!/bin/bash

if [ ! -f memory.log ]; then
	echo "Timestamp, Total (MB), Used (MB), Free (MB), Usage(%)" > memory.log
fi

while true; do
	echo "$(date '+%d-%m-%Y %H:%M:%S'), $(free -m | awk '/Mem/{print $2", "$3", "$4 ","$3/$2*100}')" >> memory.log
	sleep 60
done
