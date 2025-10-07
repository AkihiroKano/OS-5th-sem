#!/bin/bash

echo $$ > .pid
value=1
mode="+"

trap 'mode="+"' USR1
trap 'mode="*"' USR2
trap 'echo ""; exit' SIGTERM

while true; do
	case "$mode" in
		"+") value=$((value + 2)) ;;
		"*") value=$((value * 2)) ;;
	esac

	echo "Текущее значение: $value"
	sleep 1
done
