SITE=$(curl -s https://de-de.facebook.com/campustuete/ )
NUM_BERLIN=$( echo "$SITE"  | sed 's/Studierendenwerk Berlin//g'  | sed 's|Europe\\/Berlin||g' | sed 's|"47":"Berlin"||g' | sed 's|Das Original, Berlin. Gef||g' | sed 's|addressLocality":"Berlin||g' | sed 's|addressRegion":"Berlin||g' | sed 's|Dienstleistung in Berlin||g' | sed 's|10707 Berlin||g' | sed 's|15.09.2019 in Berlin||g' | sed 's|URBAN FIT DAYS in Berlin||g' | sed 's|"label":"Berlin||g'| tr ' ' '\n' | tr ',' '\n' | tr '<' '\n' | grep Berlin | wc -l )

if (( $NUM_BERLIN != 0 )); then
  notify-send "Look at Facebook Campus Tüte - Num: $NUM_BERLIN"
fi
