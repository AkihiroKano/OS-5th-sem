#!/bin/bash

# Подсчет колва процессов запущенных пользователем user(root)

USER_NAME="root"

PROCESS_COUNT=$(ps -u "$USER_NAME" --no-headers | wc -l)

echo "Колличество процессов пользователя $USER_NAME: $PROCESS_COUNT" > user_processes.log

ps -u "$USER_NAME" -o pid,cmd --no-headers >> user_processes.log
