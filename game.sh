#!/bin/bash
# Originally developed by Andrey Bova
# 10/12/2016

tick=0.1

cp field .field_temp
clear

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
    echo $key > .game_cycle
    cat .field_temp >> .game_cycle
    clear
    sed -nf bomber.sed .game_cycle | stdbuf -iK -oK cat
    sleep 0.04
done
