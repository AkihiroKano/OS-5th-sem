#!/bin/bash

echo "Запуск фоновых процессов..."

for i in {1..3}; do
	while true; do : ; done &
	echo "Процесс $i (PID: $!)"
	pids+=($!)
done

echo "${pisd[0]}" > .pid1
echo "${pids[2]}" > .pid3
