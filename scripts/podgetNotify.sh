#!/bin/bash
t=$(podget  2>&1 | grep "Downloading" | grep -v "feed index" | wc -l)

if [ $t -gt 0 ]
then
    notify-send "Podget" "New Podcast"
fi
