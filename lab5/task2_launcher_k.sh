#!/bin/bash
K=30  # Количество запусков
N=2871000

for ((i=0; i<K; i++)); do
    ./task2_newmem.sh "$N" &
    sleep 1
done
