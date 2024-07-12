#!/usr/bin/sh

COMMAND="while clear; timesheet-generator ~/Documents/Timetrack/timesheet.time | worked-today --expected 8; do inotifywait -q -e close_write ~/Documents/Timetrack/timesheet.time; done"

if [ "$1" == "-c" ]; then
    sh -c "$COMMAND"
else 
    alacritty --class Alacritty,Pseudo \
        -o window.dimensions.lines=27 \
        -o window.dimensions.columns=42 \
        --command /usr/bin/sh -c "$COMMAND"
fi
