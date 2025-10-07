#!/bin/bash

mkdir ~/test 2>/dev/null && {
	echo "каталог создан" >> ~/report
	touch ~/test/"$(date +"%d-%m-%Y_%H-%M-%S")"
}

ping -c 1 www.net_nikogo.ru >/dev/null 2>&1 || {
	echo "$(date +"%d-%m-%Y %H:%M:%S") Ошибка: хост недоступен" >> ~/report
}
