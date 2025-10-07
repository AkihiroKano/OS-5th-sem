#!/bin/bash

# Вычисление среднего времени использования CPU

OUTPUT_FILE="cpu_burst.log"
echo "" > "$OUTPUT_FILE"

for PID in $(ls /proc | grep -E '^[0-9]+$'); do
	PARENT_PID=$(awk '/PPid/ {print $2}' /proc/$PID/status 2>/dev/null)
	SUM_EXEC_RUNTIME=$(awk '/se.sum_exec_runtime/ {print $3}' /proc/$PID/sched 2>/dev/null)
	NR_SWITCHES=$(awk '/nr_switches/ {print $3}' /proc/$PID/sched 2>/dev/null)

	if [[ -n "$SUM_EXEC_RUNTIME" && -n "$NR_SWITCHES" && "$NR_SWITCHES" -ne 0 ]]; then
		ART=$(echo "scale=2; $SUM_EXEC_RUNTIME / $NR_SWITCHES" | bc)
		echo "ProcessID=$PID : Parent_ProcessID=$PARENT_PID : Average_Running_Time=$ART" >> "$OUTPUT_FILE"
	fi
done

sort -t= -k3 -n "$OUTPUT_FILE" -o "$OUTPUT_FILE"
