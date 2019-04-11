SITE=$(curl -s https://de-de.facebook.com/campustuete/ )
NUM_BERLIN=$( echo "$SITE" | tr ' ' '\n' | tr ',' '\n' | tr '<' '\n' | grep Berlin | wc -l )

if (( $NUM_BERLIN != 3 && $NUM_BERLIN != 0 )); then
  notify-send "Look at Facebook Campus Tüte - Num: $NUM_BERLIN"
fi
