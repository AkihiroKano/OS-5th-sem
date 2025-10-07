#!/bin/bash

INPUT_PIPE="./server_input"
OUTPUT_PIPE="./server_output"

[[ ! -p "$INPUT_PIPE" || ! -p "$OUTPUT_PIPE" ]] && { echo "Сервер не запущен!"; exit 1; }

generate_numbers() {
    seq 10000 99999 > .all_numbers.txt
}

filter_numbers() {
    local guess=$1
    local B=$2
    local C=$3

    awk -v guess="$guess" -v target_B="$B" -v target_C="$C" '
    function calculate_bc(target, guess,    b, c, i, target_digits, guess_digits, count) {
        split(target, target_digits, "")
        split(guess, guess_digits, "")

        b = 0
        for (i = 1; i <= 5; i++) {
            if (target_digits[i] == guess_digits[i]) {
                b++
                target_digits[i] = "X"
                guess_digits[i] = "Y"
            }
        }

        # Считаем коров (C)
        delete count
        for (i = 1; i <= 5; i++) {
            if (target_digits[i] != "X") count[target_digits[i]]++
        }

        c = 0
        for (i = 1; i <= 5; i++) {
            if (guess_digits[i] != "Y" && count[guess_digits[i]] > 0) {
                c++
                count[guess_digits[i]]--
            }
        }

        return b " " c
    }

    {
        current = $1
        split(calculate_bc(current, guess), result, " ")
        if (result[1] == target_B && result[2] == target_C) print current
    }
    ' .remaining_numbers.txt > .temp.txt

    mv .temp.txt .remaining_numbers.txt
}

generate_numbers
cp .all_numbers.txt .remaining_numbers.txt

for attempt in {1..50}; do
    # Выбираем первое число из оставшихся
    guess=$(head -1 .remaining_numbers.txt)
    echo "Попытка $attempt: $guess"
    echo "$guess" > "$INPUT_PIPE"

    read -r B C < "$OUTPUT_PIPE"

    if [[ "$B" -eq 5 ]]; then
        echo "Угадано за $attempt попыток!"
        echo "QUIT" > "$INPUT_PIPE"
        rm .all_numbers.txt .remaining_numbers.txt 2>/dev/null
        exit 0
    fi

    filter_numbers "$guess" "$B" "$C"

    if [[ ! -s .remaining_numbers.txt ]]; then
        echo "Ошибка: Нет возможных чисел!"
        exit 1
    fi
done

echo "Не угадано за 50 попыток."
echo "QUIT" > "$INPUT_PIPE"
rm .all_numbers.txt .remaining_numbers.txt 2>/dev/null
