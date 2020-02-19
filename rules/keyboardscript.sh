#!/bin/sh
export DISPLAY=":0.0"
#export XAUTHORITY="/home/nwuensche/.Xauthority"
#& here (for some reason) important, otherwise this doesn't get applied
/usr/bin/setxkbmap eu -option caps:escape &
