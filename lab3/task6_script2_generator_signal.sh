#!/bin/bash

handler_pid=$(cat .pid)

while read -r line; do
	case "$line" in
		"+") kill -USR1 "$handler_pid" ;;
		"*") kill -USR2 "$handler_pid" ;;
		TERM) kill -TERM "$handler_pid"; exit ;;
		*) ;;
	esac
done
