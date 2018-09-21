#!/bin/bash

#If fullscreen, set cursor to corner to stop xautolock from activating
while true; do
    sleep 580
    WINDOW=$(echo $(xwininfo -id $(xdotool getactivewindow) -stats | \
                    egrep '(Width|Height):' | \
                    awk '{print $NF}') | \
             sed -e 's/ /x/')
    SCREEN=$(xdpyinfo | grep -m1 dimensions | awk '{print $2}')
    if [ "$WINDOW" = "$SCREEN" ]; then
        xdotool mousemove 0 0
    fi
done
