#!/bin/bash

# Добавление строк со средним ART для процессов одного родителя

INPUT_FILE="cpu_burst.log"
OUTPUT_FILE="cpu_avg_parent.log"

echo "" > "$OUTPUT_FILE"

awk -F"=" '
{
	PPID[$4] += $6;
	COUNT[$4]++;
	print
}
END {
	for (id in PPID) {
		printf "Average_Running_Children_of_ParentID=%d is %.2f\n", id, PPID[id] / COUNT[id]
	}
}' "$INPUT_FILE" > "$OUTPUT_FILE"
