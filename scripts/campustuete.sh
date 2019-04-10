SITE=$(curl -s https://de-de.facebook.com/campustuete/ )
NUM_BERLIN=$( echo "$SITE" | tr ' ' '\n' | tr ',' '\n' | tr '<' '\n' | grep Berlin | wc -l )
echo "$NUM_BERLIN"

if (( $NUM_BERLIN != 1 )); then
  notify-send "Look at Facebook Campus Tüte"
fi
