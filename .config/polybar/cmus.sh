#!/bin/bash
prepend_zero() {
    seq -f "%02g" $1 $1
}

artist=$(echo -n $(cmus-remote -C status | grep artist -m 1 | cut -c 12-))
song=$(echo -n $(cmus-remote -C status | grep title -m 1 | cut -c 11-))

position=$(cmus-remote -C status | grep position | cut -c 10-)
if [[ $position -ne 0 ]]; then
minutes1=$(prepend_zero $(($position / 60)))
seconds1=$(prepend_zero $(($position % 60)))
fi

duration=$(cmus-remote -C status | grep duration | cut -c 10-)
if [[ $duration -ne 0 ]];then
minutes2=$(prepend_zero $(($duration / 60)))
seconds2=$(prepend_zero $(($duration % 60)))
fi

echo -n " $artist - $song [$minutes1:$seconds1 / $minutes2:$seconds2]"

