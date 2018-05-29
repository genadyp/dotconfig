#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
run udiskie -a -t
run $HOME/.screenlayout/layout.sh
