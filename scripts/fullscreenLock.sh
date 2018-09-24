#!/bin/bash

#If fullscreen, set cursor to corner to stop xautolock from activating
while true; do
    sleep 5
    #Just do this for Chromium
    NAMEWINDOW=$(echo $(xwininfo -id $(xdotool getactivewindow)) | sed -n -r '/(youtube|ted).*Chromium/Ip')
    WINDOW=$(echo $(xwininfo -id $(xdotool getactivewindow) -stats | \
                    egrep '(Width|Height):' | \
                    awk '{print $NF}') | \
             sed -e 's/ /x/')
    SCREEN=$(xdpyinfo | grep -m1 dimensions | awk '{print $2}')
    if [ "$WINDOW" = "$SCREEN" ]; then
        if [ "$NAMEWINDOW" != "" ]; then
            X=$( xdotool getmouselocation | sed -n 's/.*x:\([[:alnum:]]*\).*/\1/p' )
            Y=$( xdotool getmouselocation | sed -n 's/.*y:\([[:alnum:]]*\).*/\1/p' )
            xdotool mousemove 0 0
            xdotool mousemove `echo $X` `echo $Y`
        fi
    fi
done
