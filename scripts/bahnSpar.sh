#!/bin/sh

LIST='Super Sparpreis Aktion:
BahnCard 25 zum Jubiläumspreis:
Freifahrten, Gratis-Upgrades &amp; kostenlose BahnCard
Für alle unter 27:
25% Rabatt auf ICE-Tickets:
Flixtrain-Tickets statt
Als Gruppe ab 9,90€ im ICE fahren
Sparpreis Europa ab 13,90€
Bahn-Shop: Alles rund um die Bahn'

set -e # to stop on failing ping
ping -q -W 2 8.8.8.8 -c 2 #Check Connection

#perl does replace unicode space with normal space, last sed remove trailing space
NEWLIST=$(curl -s https://www.bahndampf.de/angebote |  sed -n 's/.*<td width="20%"><strong>\([^<]*\)\($\|<.*\)/\1/p' | perl -CSDA -plE 's/\s/ /g' | sed -e 's/[[:space:]]*$//')

if [[ "$LIST" != "$NEWLIST" ]]; then
  notify-send "Bahn Rabatt New Stuff"
  echo "$NEWLIST"
fi
