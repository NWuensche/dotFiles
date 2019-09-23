#!/bin/sh
set -e
ping -q -W 2 8.8.8.8 -c 2 #Check Connection
SITE=$(curl --connect-timeout 2 -s http://logic.las.tu-berlin.de/Teaching/ )
TBALINK=$(echo "$SITE" | sed -n '/tba.*Digraph/p' )
TBALECTIME=$(echo "$SITE" | sed -n '/tba.*Digraph/,$p' | head -n 6 | tail -n 1 | sed -n "/tba/p" )
if [[ "$TBALINK" == "" || "$TBALECTIME" = "" ]] ; then
  notify-send "Kreuzter Modules Digraph new info";
fi
