#!/bin/sh

SITE_TIME=$(curl -s https://www.zugreiseblog.de/bahn-gutschein/ | sed -n 's/.*Aktualisiert: <time class=updated datetime="\([^"]*\).*/\1/p')
LAST_TIME="2019-12-31 19:50:10"

if [[ "$SITE_TIME" != "$LAST_TIME" ]]; then
  notify-send "Bahn Rabatt New Stuff"
fi
