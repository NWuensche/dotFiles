PER=$( upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage |  awk '{print $2}' | sed 's/%//g' ) #Delete % sign
# Only natural numer CAPA to make it easier, % sign away
CAPA=$( upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep capacity |  awk '{print $2}' | sed -n 's/\(\S*\),.*/\1/p' )
CHARGE=$(( ($PER*$CAPA) / 100  ))

STATUS=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | awk '{print $2}' )

#Less than 10 percent and not charging
if  (( $CHARGE < 10 )) && [[ "$STATUS" != "charging" ]]; then
    notify-send "Charge Battery"
fi
