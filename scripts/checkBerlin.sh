#!/bin/sh
set -e
HOLIDAY=$(curl -s "https://www.bb-musikschule.de/musik-workshops-berlin-schoeneberg" | grep "werden nach den Sommerferien" || true)

if [[ "$HOLIDAY" == "" ]]; then
  notify-send "Check Workshop Berlin"
fi
