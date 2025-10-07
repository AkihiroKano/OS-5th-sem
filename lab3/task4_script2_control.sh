#!/bin/bash

pid1=$(cat .pid1)
pid3=$(cat .pid3)

# cpulimit -p $pid1 -l 10 -b

renice +19 -p $pid1

kill $pid3

echo "Процесс $pid3 завершен. CPU $pid1 ограничен до 10%."
