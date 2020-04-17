#!/bin/sh
export DISPLAY=":0.0"
#& here (for some reason) important, otherwise this doesn't get applied
/usr/bin/setxkbmap my_dvorak -option caps:escape &
