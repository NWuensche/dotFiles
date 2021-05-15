#!/bin/sh

set -e # to stop on failing ping
ping -q -W 2 8.8.8.8 -c 2 #Check Connection

SITE_TIME=$(curl -s https://www.zugreiseblog.de/bahn-gutschein/ | sed -n 's/.*Aktualisiert: <time class=updated datetime="\([^"]*\).*/\1/p')
LAST_TIME="2021-05-11 15:28:54"
echo $SITE_TIME

if [[ "$SITE_TIME" != "$LAST_TIME" ]]; then
  notify-send "Bahn Rabatt New Stuff"
fi
