#!/bin/sh

set -x

# Forget about all monitors that were disconnected
xrandr --query | grep " disconnected" | awk '{print $1}' | while IFS= read -r LINE; do
    xrandr --output $LINE --off
done


MONITOR_LIST=$(xrandr -q | awk -v maxfreq=170 '
    mon { 
        fre=$2+0; 
        for(i=2;i<=NF;i++)
            if(fre<$i+0 && $i+0<maxfreq)
                fre=$i+0;
        print mon " " $1 " " fre " " prim;
        mon = "";
        prim = "";
    } 
    / connected / { mon = $1 }
    / connected primary/ { prim = "primary" }
')


CURRENT_X=0
MAX_HEIGHT=0
MAX_SEC_WIDTH=0
SECONDARY_MONITOR=""
while IFS= read -r LINE; do
    NAME=$(echo $LINE | cut -d ' ' -f1)
    RESOLUTION=$(echo $LINE | cut -d ' ' -f2)
    WIDTH=$(echo $RESOLUTION | cut -d 'x' -f1)
    HEIGHT=$(echo $RESOLUTION | cut -d 'x' -f2)
    PRIMARY=$(echo $LINE | cut -d ' ' -f4)
    if [ "$HEIGHT" -gt "$MAX_HEIGHT" ]; then
        MAX_HEIGHT=$HEIGHT
    fi
    if [ -z "$PRIMARY" ]; then
        if [ "$WIDTH" -gt "$MAX_SEC_WIDTH" ]; then
            MAX_SEC_WIDTH=$WIDTH
            SECONDARY_MONITOR=$NAME
        fi
    fi
done <<EOF
$MONITOR_LIST
EOF

# 1. Set up biggest secondary monitor to the left
if [ -n "$SECONDARY_MONITOR" ]; then
    MONITOR=$(echo "$MONITOR_LIST" | grep "$SECONDARY_MONITOR")
    RESOLUTION=$(echo $MONITOR | cut -d ' ' -f2)
    FREQUENCY=$(echo $MONITOR | cut -d ' ' -f3)
    WIDTH=$(echo $RESOLUTION | cut -d 'x' -f1)
    HEIGHT=$(echo $RESOLUTION | cut -d 'x' -f2)
    Y=$(($MAX_HEIGHT-$HEIGHT))
    xrandr --output $SECONDARY_MONITOR --mode $RESOLUTION --refresh $FREQUENCY --pos ${CURRENT_X}x${Y}
    CURRENT_X=$((CURRENT_X+WIDTH))
fi

# 2. Set up primary monitor
MONITOR=$(echo "$MONITOR_LIST" | grep "primary")
NAME=$(echo $MONITOR | cut -d ' ' -f1)
RESOLUTION=$(echo $MONITOR | cut -d ' ' -f2)
FREQUENCY=$(echo $MONITOR | cut -d ' ' -f3)
WIDTH=$(echo $RESOLUTION | cut -d 'x' -f1)
HEIGHT=$(echo $RESOLUTION | cut -d 'x' -f2)
Y=$(($MAX_HEIGHT-$HEIGHT))
xrandr --output $NAME --primary --mode $RESOLUTION --refresh $FREQUENCY --pos ${CURRENT_X}x${Y}
CURRENT_X=$((CURRENT_X+WIDTH))

# 3. Set up the rest to the right
OTHER_MONITORS=$(echo "$MONITOR_LIST" | grep -v -e "primary" -e "$SECONDARY_MONITOR")
while IFS= read -r MONITOR; do
    NAME=$(echo $MONITOR | cut -d ' ' -f1)
    RESOLUTION=$(echo $MONITOR | cut -d ' ' -f2)
    FREQUENCY=$(echo $MONITOR | cut -d ' ' -f3)
    WIDTH=$(echo $RESOLUTION | cut -d 'x' -f1)
    HEIGHT=$(echo $RESOLUTION | cut -d 'x' -f2)
    if [ -n "$HEIGHT" ]; then
        Y=$(($MAX_HEIGHT-$HEIGHT))
        xrandr --output $NAME --mode $RESOLUTION --refresh $FREQUENCY \
            --pos ${CURRENT_X}x${Y}
        CURRENT_X=$((CURRENT_X+WIDTH))
    fi
done <<EOF
$OTHER_MONITORS
EOF

while IFS= read -r LINE; do
    NAME=$(echo $LINE | cut -d ' ' -f1)
    bspc monitor ${NAME} --reset-desktops 1 2 3 4 5 6 7 8 9 0
done <<EOF 
$MONITOR_LIST
EOF

exit 0
