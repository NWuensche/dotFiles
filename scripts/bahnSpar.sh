#!/bin/sh

LIST='9-Euro-Ticket: Gültigkeit, Buchung, Infos für Abo-Kunden
Interrail-Pass Angebote 2022: 50% Rabatt 10. Mai
Super Sparpreis Young 2022: ICE-Ticket schon ab 9,65€
Bahn Gutschein im Mai 2022 holen
Günstige Bahntickets 2022: 10 Tricks für billige ICE-Tickets ab 9,65€
DB Sparpreis-Aktion 2022: ICE-Tickets schon ab 9,65€
Nutella Bahn-Gutschein: 10€ Bahn-Rabatt in duplo, hanuta und Yogurette
DB Sommerticket 2022: Verkaufsstart, Preise, Konditionen
Aldi Bahn-Ticket: Buchungscode einlösen &#038; aktuelle Bahn-Aktionen
Toffifee Bahn-Gutschein: 10€ DB-eCoupon in allen Aktionspackungen'

set -e # to stop on failing ping
ping -q -W 2 8.8.8.8 -c 2 #Check Connection

#ping -q -W 2 www.bahndampf.de -c 2 #Check Connection to prevent false notifications
#perl does replace unicode space with normal space, last sed remove trailing space
NEWLIST=$(curl -s https://www.bahndampf.de/angebote | sed -n 's/.*<h3[^_]*_self">\([^<]*\)<.*/\1/p' | perl -CSDA -plE 's/\s/ /g' | sed -e 's/[[:space:]]*$//')
sleep 10
NEWLIST2=$(curl -s https://www.bahndampf.de/angebote | sed -n 's/.*<h3[^_]*_self">\([^<]*\)<.*/\1/p' | perl -CSDA -plE 's/\s/ /g' | sed -e 's/[[:space:]]*$//')

if [[ "$LIST" != "$NEWLIST" &&  "$LIST" != "$NEWLIST2" ]]; then #Sometimes with only one wrong
  notify-send "Bahn Rabatt New Stuff"
  echo "$NEWLIST"
fi
