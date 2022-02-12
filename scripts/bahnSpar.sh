#!/bin/sh

set -e # to stop on failing ping
ping -q -W 2 8.8.8.8 -c 2 #Check Connection

SITE_TIME=$(curl -s --head https://www.bahndampf.de/angebote | sed -n 's/last-modified: \(.*\)./\1/p' ) #Ends on <C-M> for some reason
LAST_TIME="Sun, 06 Feb 2022 15:20:36 GMT"

if [[ "$SITE_TIME" != "$LAST_TIME" ]]; then
  notify-send "Bahn Rabatt New Stuff"
  echo "$SITE_TIME"
fi
