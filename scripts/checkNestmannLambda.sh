#!/bin/sh
set -e
ping -q -W 2 8.8.8.8 -c 2 #Check Connection
SITE=$(curl --connect-timeout 2 -s https://www.mtv.tu-berlin.de/menue/lehre/module/latys/ )
LASTUPDATE=$(echo "$SITE" | sed -n '/Zuletzt aktualisiert:&nbsp;23\.05\.19/p' )
if [[ "$LASTUPDATE" == "" ]] ; then
  notify-send "Nestmann Lambda new Infos";
fi
