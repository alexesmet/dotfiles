#!/bin/sh
# colorsheme tomorrow night bright
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]; then
    echo "%{F#848089}睊"
elif [ $(echo info | bluetoothctl | grep 'Device ' | wc -c) -eq 0 ]; then 
    echo "%{F#e3e1e4}睊"
else
    echo "%{F#7accd7}直"
fi
