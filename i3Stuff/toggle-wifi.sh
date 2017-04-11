#!/bin/bash

if nmcli radio wifi | grep -q "deaktiviert" ; then
    nmcli radio wifi on
else
    nmcli radio wifi off
fi
