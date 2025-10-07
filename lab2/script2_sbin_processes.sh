#!/bin/bash

# Вывод списка PID процессов, запущенных из /sbin/

ps -eo pid,cmd --no-headers | awk '$2 ~ /^\/sbin\// {print $1}' > sbin_processes.log
