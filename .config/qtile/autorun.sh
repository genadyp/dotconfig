#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
run hsetroot -center ~/.wallpapers/man_mountains_structure_120852_2560x1440.jpg
run udiskie -a -t
