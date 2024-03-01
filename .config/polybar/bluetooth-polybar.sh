#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]; then
    echo "%{F#666666}睊"
elif [ $(echo info | bluetoothctl | grep 'Device ' | wc -c) -eq 0 ]; then 
    echo "%{F#eeeeee}睊"
else
    echo "%{F#73cef4}直"
fi
