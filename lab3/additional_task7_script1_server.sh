#!/bin/bash

INPUT_PIPE="./server_input"
OUTPUT_PIPE="./server_output"
mkfifo "$INPUT_PIPE" "$OUTPUT_PIPE" 2>/dev/null

TARGET=$(( RANDOM % 90000 + 10000 ))
echo "Сервер загадал число: $TARGET" >&2

calculate_bc() {
    local target=$1
    local guess=$2
    local B=0
    local C=0

    local target_digits=($(echo "$target" | grep -o .))
    local guess_digits=($(echo "$guess" | grep -o .))

    for i in {0..4}; do
        if [[ "${target_digits[i]}" == "${guess_digits[i]}" ]]; then
            ((B++))
            target_digits[i]="X"
            guess_digits[i]="Y"
        fi
    done

    declare -A count
    for d in "${target_digits[@]}"; do
        [[ "$d" != "X" ]] && ((count[$d]++))
    done

    for d in "${guess_digits[@]}"; do
        if [[ "$d" != "Y" && -n "${count[$d]}" && "${count[$d]}" -gt 0 ]]; then
            ((C++))
            ((count[$d]--))
        fi
    done

    echo "$B $C"
}

while true; do
    guess=$(cat "$INPUT_PIPE")
    
    if [[ "$guess" == "QUIT" ]]; then
        break
    fi

    if ! [[ "$guess" =~ ^[0-9]{5}$ ]]; then
        echo "ERROR" > "$OUTPUT_PIPE"
        continue
    fi

    result=$(calculate_bc "$TARGET" "$guess")
    echo "$result" > "$OUTPUT_PIPE"
done

rm -f "$INPUT_PIPE" "$OUTPUT_PIPE"
