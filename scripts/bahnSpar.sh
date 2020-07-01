#!/bin/sh

SITE_TIME=$(curl -s https://www.zugreiseblog.de/bahn-gutschein/ | sed -n 's/.*Aktualisiert: <time class=updated datetime="\([^"]*\).*/\1/p')
LAST_TIME="2020-06-01 11:21:07"
echo $SITE_TIME

if [[ "$SITE_TIME" != "$LAST_TIME" ]]; then
  notify-send "Bahn Rabatt New Stuff"
fi
