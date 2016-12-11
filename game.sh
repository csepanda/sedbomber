#!/bin/bash
# Originally developed by Andrey Bova
# 10/12/2016

tick=0.1

clear

rm -f .game_tube
mkfifo .game_tube

exec 5<>.game_tube
sed -nf bomber.sed .game_tube &
cat field >&5

while :; do
    read -s -n 1 -t $tick key
    case $key in
        # First player movement : wasd
        w) key='[cmd_1_up]'    ;;
        a) key='[cmd_1_left]'  ;;
        s) key='[cmd_1_down]'  ;;
        d) key='[cmd_1_right]' ;;
        e) key='[cmd_1_plant]' ;;
        *) key='[cmd_nothing]' ;;
    esac
    echo $key>&5
    sleep 0.04
done
