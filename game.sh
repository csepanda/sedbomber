#!/bin/bash
# Originally developed by Andrey Bova
# 10/12/2016

tick=0.1
index=1
bonus_count=32
clear
trap 'kill -9 -$$' 2

rm -f .game_tube
mkfifo .game_tube
exec 5<>.game_tube
sed -nrf bomber.sed .game_tube &
cat field>&5

while [ $index -le $bonus_count ]
do    
    bin=`printf '%02d' $index`
    echo [RANDOM_NUMBER:$bin`expr $RANDOM \* 6661337`:NR]>&5    
    index=`expr $index + 1`
done
while :; do    
    if 
        read -s -n 1 -t $tick key; then
        sleep 0.05
    fi
    case $key in
        # First player movement : wasd
        'w') key='[cmd_1_up]'    ;;
        'a') key='[cmd_1_left]'  ;;
        's') key='[cmd_1_down]'  ;;
        'd') key='[cmd_1_right]' ;;
        'e') key='[cmd_1_plant]' ;;

        'k') key='[cmd_2_up]'    ;;
        'h') key='[cmd_2_left]'  ;;
        'j') key='[cmd_2_down]'  ;;
        'l') key='[cmd_2_right]' ;;
        ';') key='[cmd_2_plant]' ;;

        '') read -s -n 2 key 
              case $key in 
                '[A') key='[cmd_3_up]'    ;;
                '[D') key='[cmd_3_left]'  ;;
                '[B') key='[cmd_3_down]'  ;;
                '[C') key='[cmd_3_right]' ;;
              esac                  ;;
        '/'   ) key='[cmd_3_plant]' ;;

        '8') key='[cmd_4_up]'    ;;
        '4') key='[cmd_4_left]'  ;;
        '5') key='[cmd_4_down]'  ;;
        '6') key='[cmd_4_right]' ;;
        '7') key='[cmd_4_plant]' ;;

        *) key='[cmd_nothing]' ;;
    esac
    echo $key>&5
    while read -r -t 0; do read -r -t 0.001; done
done
