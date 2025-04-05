#!/bin/sh

set -x

# Get the primary monitor
PRIMARY_MONITOR=$(xrandr --query | grep " connected primary" | awk '{print $1}')
echo "PRIMARY_MONITOR=$PRIMARY_MONITOR"

# Get all currently connected monitors
CONNECTED_MONITORS="$(xrandr --query | grep " connected" | awk '{print $1}')"
echo "Connected monitors: $CONNECTED_MONITORS"


bspc query -M --names | while IFS= read -r BSPWM_MON; do
    THIS_BSPWM_MON_ACTIVE=""
    while IFS= read -r ACTIVE_MON; do
        if [ "$BSPWM_MON" == "$ACTIVE_MON" ]; then
            THIS_BSPWM_MON_ACTIVE="yes"
            break
        fi
    done <<EOF
$CONNECTED_MONITORS
EOF


    if [ -z "$THIS_BSPWM_MON_ACTIVE" ]; then
        echo "Found inactive monitor: $BSPWM_MON"
        # Move to the respective (same name) desktop of primary monitor
        for NODE in $(bspc query -N -m $BSPWM_MON); do
            THIS_D=$(bspc query -D -n $NODE)
            DESKTOP_ORDER=$(bspc query -D -m $BSPWM_MON | grep $THIS_D -n | cut -f1 -d:)
            NEW_DESKTOP_ID=$(bspc query -D -d "$PRIMARY_MONITOR:^$DESKTOP_ORDER")
            echo "Moving $NODE to desktop $NEW_DESKTOP_ID on $PRIMARY_MONITOR"
            bspc node $NODE --to-monitor $PRIMARY_MONITOR --to-desktop $NEW_DESKTOP_ID
        done
        # Delete dangling desktops from the inactive monitor
        for DESKTOP in $(bspc query -D -m $BSPWM_MON); do
            bspc desktop $DESKTOP -r
        done
        # Remove the monitor from bspwm
        bspc monitor $BSPWM_MON -r
    fi
done


exit 0


