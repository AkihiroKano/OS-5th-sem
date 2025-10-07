#!/bin/bash

current_day=$(date +%u)

(crontab -l 2>/dev/null; echo "*/5 * * * $current_day $(pwd)/task1_script1.sh") | crontab -

echo "Задание добавлено в cron"
