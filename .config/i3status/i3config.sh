#!/bin/bash

# shell scipt to prepend i3status with more stuff

i3status | while :
do
        read line
        LAYOUT=$(setxkbmap -query | awk '/layout/{print $2}') 
        echo "  $LAYOUT  $line" || exit 1
done
