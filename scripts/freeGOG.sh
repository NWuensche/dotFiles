#!/bin/sh
set -e 
FREE=$(curl --connect-timeout 2 -s https://www.freegamekeys.com/gog/ --compressed | sed -n '/Free/p' | head -n 2 | tail -n 1 | sed -n '/Free+DISTRAINT/p' ) #If DISTRAINT isn't the latest free game anymore, then notify me
if [[ "$FREE" == "" ]] ; then
  notify-send "GOG Free Game";
fi
