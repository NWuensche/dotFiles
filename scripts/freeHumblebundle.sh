#!/bin/sh

FREE=$(curl -s https://www.humblebundle.com/store | grep -i "<p.*Free.*time")

if [[ "$FREE" != "" ]] ; then
  notify-send "Humblebundle Free Game";
  sleep 300;
  notify-send "Humblebundle Free Game";
fi
