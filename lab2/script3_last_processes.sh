#!/bin/bash

# Поиск процесса, запущенного последним

LAST_PID=$(ps -eo pid,lstart --sort=start_time | tail -n 1 | awk '{print $1}')

echo "Послелдний запушенный процесс имеет $LAST_PID PID"
