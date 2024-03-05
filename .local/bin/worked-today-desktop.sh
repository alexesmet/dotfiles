#!/usr/bin/sh

alacritty --class Pseudo,Alacritty \
    -o window.dimensions.lines=27 \
    -o window.dimensions.columns=42 \
    --command /usr/bin/sh -c "while clear; timesheet-generator ~/Documents/Timetrack/timesheet.time | worked-today --expected 8; do inotifywait -q -e close_write ~/Documents/Timetrack/timesheet.time; done"
