#!/bin/bash
file=$1

# Начало измерения времени
start_time=$(date +%s.%N)

# Определяем исходное количество строк
original_lines=$(wc -l < "$file")

# Временный файл для чтения исходных данных
tmp_read="${file}.read.tmp"
cp "$file" "$tmp_read"

# Обрабатываем каждую исходную строку
for ((i=1; i<=original_lines; i++)); do
    # Читаем i-ю строку из временного файла
    number=$(sed -n "${i}p" "$tmp_read")
    
    # Умножаем на 2 и дописываем в конец исходного файла
    echo $((number * 2)) >> "$file"
done

# Удаляем временный файл
rm "$tmp_read"

# Конец измерения времени
end_time=$(date +%s.%N)

# Вычисляем время выполнения с точностью до миллисекунд
elapsed_time=$(echo "$end_time - $start_time" | bc -l | xargs printf "%.3f")

# Выводим время выполнения
echo "Файл $file обработан за ${elapsed_time} секунд"
