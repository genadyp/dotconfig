#!/bin/zsh
if [ "$(tty)" = "/dev/tty1" ]; then
    startx && exit
fi
