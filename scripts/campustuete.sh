SITE=$(curl -s https://de-de.facebook.com/campustuete/ )
NUM_BERLIN=$( echo "$SITE"  | sed 's/Studierendenwerk Berlin//g'  | sed 's|Europe\\/Berlin||g' | sed 's|"47":"Berlin"||g' | tr ' ' '\n' | tr ',' '\n' | tr '<' '\n' | grep Berlin | wc -l )

if (( $NUM_BERLIN != 0 )); then
  notify-send "Look at Facebook Campus Tüte - Num: $NUM_BERLIN"
fi
