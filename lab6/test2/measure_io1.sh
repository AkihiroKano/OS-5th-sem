#!/bin/bash

rm -f io_1_serial.txt io_1_parallel.txt

# Последовательный запуск
for n in {1..20}; do
    echo "N=$n (Serial)..."
    for run in {1..10}; do
        ./restore_files.sh
        /usr/bin/time -f "%e" -o tmp_time.txt ./serial_io.sh "$n"
        cat tmp_time.txt >> io_1_serial.txt
    done
done

# Параллельный запуск
for n in {1..20}; do
    echo "N=$n (Parallel)..."
    for run in {1..10}; do
        ./restore_files.sh
        /usr/bin/time -f "%e" -o tmp_time.txt ./parallel_io.sh "$n"
        cat tmp_time.txt >> io_1_parallel.txt
    done
done

rm tmp_time.txt
