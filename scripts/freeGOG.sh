#!/bin/sh
set -e
ping -W 2 8.8.8.8 -c 2 #Check Connection
FREE=$(curl --connect-timeout 2 -s https://www.freegamekeys.com/gog/ --compressed | sed -n '/Check Giveaway/p' | head -n 1 | sed -n '/Freespace/p' ) #If DISTRAINT isn't the latest free game anymore, then notify me
if [[ "$FREE" == "" ]] ; then
  notify-send "GOG Free Game";
fi
