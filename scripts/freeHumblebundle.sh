#!/bin/sh

FREE=$(curl --connect-timeout 2 -s https://www.humblebundle.com/store | grep -i "<p.*Free.*time")

if [[ "$FREE" != "" ]] ; then
  notify-send "Humblebundle Free Game";
fi
