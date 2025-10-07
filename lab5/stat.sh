#!/bin/bash

free -h | grep Mem | awk '{print "Общий объем ОЗУ: " $2}'
free -h | grep Swap | awk '{print "Объем swap: " $2}'
getconf PAGE_SIZE | awk '{print "Размер страницы: " $1 " байт"}'
free -h | grep Mem | awk '{print "Свободно ОЗУ: " $4}'
free -h | grep Swap | awk '{print "Свободно swap: " $4}'
