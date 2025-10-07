#!/bin/bash
N=$1
for ((i=1; i<=N; i++)); do
    ./compute 450000 "$i" > /dev/null  # Подавление вывода
done
