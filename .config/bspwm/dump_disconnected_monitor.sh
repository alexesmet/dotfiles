#!/bin/sh

# Get the primary monitor
PRIMARY_MONITOR=$(xrandr --query | grep " connected primary" | awk '{print $1}')
PRIMARY_DESKTOP=$(bspc query -D -m $PRIMARY_MONITOR | tail -n 1)

# Get all currently connected monitors
CONNECTED_MONITORS="$(xrandr --query | grep " connected" | awk '{print $1}')"



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
        for NODE in $(bspc query -N -m $BSPWM_MON); do
            bspc node $NODE --to-monitor $PRIMARY_MONITOR --to-desktop $PRIMARY_DESKTOP
        done
        for DESKTOP in $(bspc query -D -m $BSPWM_MON); do
            bspc desktop $DESKTOP -r
        done
        # Remove the monitor from bspwm
        bspc monitor $BSPWM_MON -r

    fi
done


exit 0


