WHOLE_EUROS=$( curl https://www.bitcoin.de/ -s | sed -n 's/.*Aktueller Bitcoin Kurs:.*>\(.*\)€.*/\1/p' | sed 's/\.//' | sed 's/,.*//')

if (( $WHOLE_EUROS > 55000 )) ; then
  notify-send "Bitcoin Worth now over 55000€"
fi
