#!/bin/bash

if [ $# -eq 0 ]; then
    echo "command must not be empty"
    exit
fi

if [ $# -eq 1 ]; then
    if [ $1 = "adb" ]; then
        $1
        exit
    fi
fi

if [ $2 == 'version' ]; then
    echo 'adb-peco version 1.1.0'
fi

case $2 in
    'devices'| 'version' | 'help' | 'connect' | 'disconnect' | 'wait-for-device' | 'start-server' | 'kill-server' ) $1 ${@:2}; exit;;
esac

count=`adb devices | sed '/^$/d' | wc -l`

if [ $count -eq 1 ]; then
	echo "device not found"
	exit
fi

if [ $count -eq 2 ]; then
	device=`adb devices | sed -e "1,1d"`
else
	device=`adb devices | sed -e "1,1d" | peco`
fi


if [ "$device" = "" ]; then
    exit
fi

IFS="	" read -r id state <<< "$device"

echo "$1 -s $id ${@:2}"
$1 -s $id ${@:2}
