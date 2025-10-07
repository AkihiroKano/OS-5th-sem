#!/bin/bash
N=$1
for ((i=1; i<=N; i++)); do
    ./process_file.sh "file${i}.txt"
done
