#!/bin/sh
FREE=$(curl --connect-timeout 2 -s https://www.freegamekeys.com/gog/ --compressed | sed -n '/Free/p' | head -n 2 | tail -n 1 | sed -n '/Free+Obduction/p' ) #If DISTRAINT isn't the latest free game anymore, then notify me
if [[ "$FREE" == "" ]] ; then
  notify-send "GOG Free Game";
fi
