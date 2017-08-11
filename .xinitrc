#!/bin/bash

setxkbmap -option ctrl:nocaps

xrdb ~/.Xresources
lb=$(xrdb -query -all | grep '*color0' | awk '{print $2}')
lf=$(xrdb -query -all | grep '*color5' | awk '{print $2}')
nf=$(xrdb -query -all | grep '*color9' | awk '{print $2}')
cf=$(xrdb -query -all | grep '*color1' | awk '{print $2}')
dunst -lb ${lb} -lf ${lf} -nb ${lb} -nf ${nf} -cb ${lb} -cf ${cf} &

exec i3
