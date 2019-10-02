#!/bin/sh
set -e
ping -q -W 2 8.8.8.8 -c 2 #Check Connection
SITE=$(curl --connect-timeout 2 -s http://logic.las.tu-berlin.de/Teaching/ )
TBALINKD=$(echo "$SITE" | sed -n '/tba.*Digraph/p' )
TBALINKA=$(echo "$SITE" | sed -n '/tba.*Algorithmic Graph Structure Theory/p' )
TBALECTIMEA=$(echo "$SITE" | sed -n '/tba.*Algorithmic Graph Structure Theory/,$p' | head -n 6 | tail -n 1 | sed -n "/tba/p" )
if [[ "$TBALINKD" == "" || "$TBALINKA" == ""  || "$TBALECTIMEA" = "" ]] ; then
  notify-send "Kreuzter Modules Digraph or Alg new info";
fi
