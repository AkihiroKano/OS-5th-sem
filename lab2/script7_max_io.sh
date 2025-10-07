#!/bin/bash

# Определние процессов, которые считали больше всего данных за 1 минуту

TMP_FILE="io_data_start.log"
TOP_PROCESSES="top_io_processes.log"

> "$TMP_FILE"
> "$TOP_PROCESSES"

for PID in $(ls /proc | grep -E '^[0-9]+$'); do
	READ_BYTES=$(awk '/read_bytes/ {print $2}' /proc/$PID/io 2>/dev/null)
	if [[ -n "$READ_BYTES" ]]; then
		echo "$PID $READ_BYTES" >> "$TMP_FILE"
	fi
done

sleep 60

echo "Топ 3 процесса по чтению данных за минуту:" > "$TOP_PROCESSES"
while read PID START_READ; do
	END_READ=$(awk '/read_bytes/ {print $2}' /proc/$PID/io 2>/dev/null)
	DIFF=$((END_READ - START_READ))
	echo "$PID:$DIFF" >> "$TOP_PROCESSES"
done < "$TMP_FILE"

sort -t: -k2 -nr "$TOP_PROCESSES" | head -n 3
