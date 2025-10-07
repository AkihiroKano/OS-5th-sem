#!/bin/bash
# Очистка старых данных
rm -f cpu_2_serial.txt cpu_2_parallel.txt

# Эксперимент с 2 CPU (последовательно)
for n in {1..20}; do
    echo "Testing N=$n (Serial)..."
    for run in {1..10}; do
        /usr/bin/time -f "%e" -o tmp_time.txt ./serial.sh "$n"
        cat tmp_time.txt >> cpu_2_serial.txt
    done
done

# Эксперимент с 2 CPU (параллельно)
for n in {1..20}; do
    echo "Testing N=$n (Parallel)..."
    for run in {1..10}; do
        /usr/bin/time -f "%e" -o tmp_time.txt ./parallel.sh "$n"
        cat tmp_time.txt >> cpu_2_parallel.txt
    done
done

rm tmp_time.txt
