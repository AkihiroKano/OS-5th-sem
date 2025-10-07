#!/bin/bash

# Поиск процесса с максимальным потреблением памяти

MAX_PID=""
MAX_MEM=0

for PID in $(ls /proc | grep -E '^[0-9]+$'); do
	MEM=$(awk '{print $1}' /proc/$PID/statm 2>/dev/null)
	if [[ -n "$MEM" && "$MEM" -gt "$MAX_MEM" ]]; then
		MAX_MEM=$MEM
		MAX_PID=$PID
	fi
done

echo "Процессов с максимальным использованием памяти: PID=$MAX_PID, MEMORY=$MAX_MEM"
echo "Для сравнения, top:"
top -b -o %MEM -n 1 | head -n 12
