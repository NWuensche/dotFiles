#!/bin/bash
t=$(podget  2>&1 | grep "Downloading" | grep -v "feed index" | wc -l)

if [ $t -gt 0 ]
then
    notify-send -t 10000000 "Podget" "New Podcast"
fi
