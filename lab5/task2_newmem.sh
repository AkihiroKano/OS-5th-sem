#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Использование: $0 <MAX_SIZE>"
    exit 1
fi

N=$1
array=()

while (( ${#array[@]} < N )); do
    array+=({1..10})
done
