#!/bin/sh

set -e

OLDIFS=$IFS

IFS=$'\n' # Change delimiter for creating array
out=$(echo "list-sink-inputs" | pacmd | sed 's/[[:space:]]*\([[:alnum:]].*\)/\1/') #get all programs with properties and remove trailing spaces
clients=($( echo "${out}" | grep "client:" | sed 's/.*<\(.*\)>/\1/g')) #Get all program names
indices=($(echo "${out}" | grep "index:" | sed 's/index: \([[:digit:]]*\)/\1/')) #Get indices of all programs
muted=($(echo "${out}" | grep "muted:" | sed 's/muted: \([[:alpha:]]*\)/\1/')) #Get Array if program muted or not

for i in "${!clients[@]}"; do
  echo "$((${i} + 1)):" ${clients[${i}]}
done
echo -n "Which program to toggle? "
read index

index=$((index - 1)) #Showed it from 1 beginning
toToggle=$(echo "${indices[${index}]}")
isMuted=$(echo "${muted[${index}]}")

if [[ $isMuted == 'no' ]]; then
  pacmd set-sink-input-mute "${toToggle}" 1 >/dev/null #mute
else
  pacmd set-sink-input-mute "${toToggle}" 0 >/dev/null #unmute
fi

IFS=$OLDIFS
