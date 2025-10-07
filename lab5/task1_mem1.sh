#!/bin/bash
> report1.log  # Очистка файла отчёта
array=()
counter=0

while true; do
    array+=({1..10})  # Добавить 10 элементов
    ((counter++))
    if ((counter % 100000 == 0)); then
        echo "Размер массива: ${#array[@]}" >> report1.log
    fi
done
