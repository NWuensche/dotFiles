BATTERYPATH=$(upower --dump | sed -n 's|Device: \(\S*BAT\S\)|\1|p')
PER=$( upower -i $BATTERYPATH | grep percentage |  awk '{print $2}' | sed 's/%//g' ) #Delete % sign
# Only natural numer CAPA to make it easier, % sign away
CAPA=$( upower -i $BATTERYPATH | grep capacity |  awk '{print $2}' | sed 's/%//g' | sed 's/^\([^,]*\).*/\1/' ) #Delete % sign
#CAPA=$( upower -i $BATTERYPATH  ) #Delete % sign
echo $CAPA
CHARGE=$(( ($PER * $CAPA) / 100  ))

STATUS=$(upower -i $BATTERYPATH | grep state | awk '{print $2}' )

#Less than 10 percent and not charging
if  (( $CHARGE < 10 )) && [[ "$STATUS" != "charging" ]]; then
    notify-send "Charge Battery"
fi
