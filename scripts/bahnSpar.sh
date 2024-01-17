#!/bin/sh

LIST='Sparpreis-Hammer!
BahnCard-Angebot:
20% Friends-Rabatt auf ICE-Tickets sichern!
24€ Rabatt auf Bahn &amp; Hotel Städtereise
Flexpreis Aktion: Spar-Ticket für Reisen ohne Zugbindung
Sparpreis Europa ab 13,90€
Als Gruppe ab 8,90€ im ICE fahren
Für alle unter 27: Super Sparpreis Young
Für alle ab 65: Super Sparpreis Senioren
Freifahrten, Bahn-Gutscheine &amp; kostenlose BahnCard
Nachtzug-Tickets ab 29,90€
Flixtrain-Tickets ab 4,99€
TGV, Eurostar &amp; Co.:
Bahn-Shop: Alles rund um die Bahn'

set -e # to stop on failing ping
ping -q -W 2 8.8.8.8 -c 2 #Check Connection

#ping -q -W 2 www.bahndampf.de -c 2 #Check Connection to prevent false notifications
#perl does replace unicode space with normal space, last sed remove trailing space
#Old Articles from 2019 in when they get updated for some reason - NEWLIST=$(curl -s https://www.bahndampf.de/angebote | sed -n 's/.*<h3[^_]*_self">\([^<]*\)<.*/\1/p' | perl -CSDA -plE 's/\s/ /g' | sed -e 's/[[:space:]]*$//')
#sed tbody because bahn has this table twice, but we only want one of them
#NEWLIST=$(curl -s https://www.bahndampf.de/angebote | sed -n '0,/\/tbody/p' |  sed -n 's/.*<td width="20%"><strong>\([^<]*\)\($\|<.*\)/\1/p' | perl -CSDA -plE 's/\s/ /g' | sed -e 's/[[:space:]]*$//')
NEWLIST=$(curl -s https://www.bahndampf.de/angebote | sed -n 's/.*<td width="20%">\(<strong><b>\|<b>\|<strong>\)\([^<]*\)\($\|<.*\)/\2/p' | perl -CSDA -plE 's/\s/ /g' | sed -e 's/[[:space:]]*$//') #order in or important, will greeedly take first one (not "largest one"

if [[ "$LIST" != "$NEWLIST" ]]; then #Sometimes with only one wrong
  notify-send "Bahn Rabatt New Stuff"
  echo "$NEWLIST"
fi
