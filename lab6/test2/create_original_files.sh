#!/bin/bash

for i in {1..20}; do
    filename="file${i}.txt"
    if [ -f "$filename" ]; then
        rm -f "$filename"
        echo "Файл $filename удален"
    else
        echo "Файл $filename не существует, пропускаем"
    fi
done

if [ -d "backups" ]; then
    rm -rf "backups"
    echo "Директория backups удалена"
else
    echo "Директория backups не существует, пропускаем"
fi

echo "Очистка завершена"

mkdir -p backups
for i in {1..20}; do
    seq 1 1500 > "file${i}.txt"
    cp "file${i}.txt" "backups/file${i}.original"
done

echo "20 файлов и дирректория backups созданы"
