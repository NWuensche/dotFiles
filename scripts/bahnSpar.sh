#!/bin/sh

LIST='Haribo Bahn-Gutschein 2022: 10€ DB eCoupon ab Juni im Handel
9-Euro-Ticket: Alles, was Sie jetzt wissen müssen!
Deutsche Bahn Gewinnspiel 2022: Bahn-Gutscheine, Upgrades und Prämien beim DB Gewinnspiel!
BahnCard Aktion 2022: BahnCard-Angebote ab 17,90€
Günstige Bahntickets 2022: 10 Tricks für billige ICE-Tickets ab 9,65€
DB Sommerticket 2022: Verkaufsstart, Preise, Konditionen
Aus maxdome onboard wird Joyn Selection: Alle Infos
Nutella Bahn-Gutschein: 10€ Bahn-Rabatt in duplo, hanuta und Yogurette
DB Adventskalender 2021: Die besten Kalender &#038; Gewinne im Überblick!
Aldi Bahn-Ticket: Buchungscode einlösen &#038; aktuelle Bahn-Aktionen'

set -e # to stop on failing ping
ping -q -W 2 8.8.8.8 -c 2 #Check Connection

#ping -q -W 2 www.bahndampf.de -c 2 #Check Connection to prevent false notifications
#perl does replace unicode space with normal space, last sed remove trailing space
NEWLIST=$(curl -s https://www.bahndampf.de/angebote | sed -n 's/.*<h3[^_]*_self">\([^<]*\)<.*/\1/p' | perl -CSDA -plE 's/\s/ /g' | sed -e 's/[[:space:]]*$//')

if [[ "$LIST" != "$NEWLIST" ]]; then #Sometimes with only one wrong
  notify-send "Bahn Rabatt New Stuff"
  echo "$NEWLIST"
fi
