#!/bin/bash

mode="+"
result=1

tail -f pipe | while read -r line; do
	case "$line" in
		"+") mode="+" ;;
		"*") mode="*" ;;
		QUIT) echo "Плановая остановка"; killall tail; exit ;;
		*)
			if [[ "$line" =~ ^[0-9]+$ ]]; then
				result=$((result $mode line))
				echo "Результат: $result"
			else
				echo "Ошибка данных"; killall tail; exit 1
			fi
			;;
	esac
done
