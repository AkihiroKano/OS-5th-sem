#!/bin/bash
# Запускает основной скрипт и мониторит его ресурсы

# Запуск основного скрипта в фоне
./task1_mem2.sh &
MAIN_PID=$!

> memory_usage2.log

# Функция для завершения мониторинга
cleanup() {
    kill $TOP_PID 2>/dev/null
    exit 0
}

# Перехват сигналов прерывания
trap cleanup SIGINT SIGTERM

# Мониторинг ресурсов
(
    while true; do
        if ! ps -p $MAIN_PID > /dev/null; then
            break
        fi
        
        # Получаем данные о памяти, свопе и кэше через free
        free -k | awk -v date="$(date +'%Y-%m-%d %H:%M:%S')" '
            /Mem:/ { 
                total_mem = $2;
                used_mem = $3; 
                free_mem = $4; 
                buff_cache = $6;  # 6-й столбец в выводе free -k
                printf "%s | Mem: Used=%s, Free=%s, Buff/Cache=%s\n", 
                       date, used_mem, free_mem, buff_cache
            }
            /Swap:/ { 
                printf "%s | Swap: Used=%s, Free=%s\n", 
                       date, $3, $4 
            }
        '
        
        # Получаем данные процесса через top
        top -b -n 1 -p $MAIN_PID | awk -v pid="$MAIN_PID" -v date="$(date +'%Y-%m-%d %H:%M:%S')" '
            $1 == pid { 
                printf "%s | Process: VIRT=%s RES=%s MEM=%s%%\n", 
                       date, $5, $6, $10 
            }
        '
        
        sleep 1
    done
) >> memory_usage2.log &

TOP_PID=$!

# Ожидание завершения основного процесса
wait $MAIN_PID

# Завершение мониторинга
cleanup
