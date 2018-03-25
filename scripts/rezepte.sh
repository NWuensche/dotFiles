#!/bin/bash

for i in `seq 1 10`;
do
    wget https://www.chefkoch.de/rezepte/zufallsrezept/ -qO- | awk -F 'title>' '{print $2}' | awk -F '|' '{print $1}' |  tr -d '\n' | awk -F 'Chefkoch.de' '{print $1}' | sed 's/\&auml\;/\ä/g' | sed 's/\&Auml\;/\Ä/g' | sed 's/\&ouml\;/\ö/g' | sed 's/\&Ouml\;/\Ö/g' | sed 's/\&uuml\;/\ü/g' | sed 's/\&Uuml\;/\Ü/g' | sed 's/\&szlig\;/\ß/g'
done
