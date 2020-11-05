SITE=$(curl -s https://de-de.facebook.com/campustuete/ )
NUM_BERLIN=$( echo "$SITE"  | sed 's/Studierendenwerk Berlin//g'  | sed 's|Europe\\/Berlin||g' | sed 's|"47":"Berlin"||g' | sed 's|Das Original, Berlin. Gef||g' | sed 's|addressLocality":"Berlin||g' | sed 's|addressRegion":"Berlin||g' | sed 's|Dienstleistung in Berlin||g' | sed 's|10707 Berlin||g' | sed 's|15.09.2019 in Berlin||g' | sed 's|URBAN FIT DAYS in Berlin||g' | sed 's|"label":"Berlin||g'| sed 's|LateNightBerlin||g' | sed 's|Late Night Berlin||g' | sed 's|holzrichterberlin||g' | sed 's|HOLZRICHTER Berlin||g' | sed 's|wohnung.frei.berlin||g'  | sed 's|Wohnung frei in Berlin||g' | sed 's|Berliner Luft||g' | sed 's|berlinerluft||g' | tr ' ' '\n' | tr ',' '\n' | tr '<' '\n' | grep -i Berlin | wc -l )
if (( $NUM_BERLIN != 0 )); then
  notify-send "Look at Facebook Campus Tüte - Num: $NUM_BERLIN"
fi
