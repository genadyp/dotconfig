#!/bin/bash

SEL=$($HOME/.config/rofi/windows | rofi -dmenu -p "hidden: " -a 0 -no-custom -lines 5 -width 40  | awk '{print $1}' )

bspc node $SEL -g hidden=off;bspc node -f $SEL
