#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]; then
    echo "%{F#7c6f64}睊"
elif [ $(echo info | bluetoothctl | grep 'Device ' | wc -c) -eq 0 ]; then 
    echo "睊"
else
    echo "%{F#2193ff}直"
fi
