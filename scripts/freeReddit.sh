#!/bin/sh

set -e
FREE=$(curl --connect-timeout 2 -s 'https://www.reddit.com/r/FreeGamesOnSteam/top?t=month' -H 'authority: www.reddit.com' -H 'cache-control: max-age=0' -H 'upgrade-insecure-requests: 1' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36' -H 'dnt: 1' -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: de-DE,de;q=0.9,en-US;q=0.8,en;q=0.7' --compressed | sed -n '/<h2/p' | head -n 1 | egrep -i "estranged|DLC" ) #If Grid 2 or a DLC isn't the latest free game anymore, then notify me
if [[ "$FREE" == "" ]] ; then
  notify-send "Reddit Free Game Top Month";
fi
