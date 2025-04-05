#!/usr/bin/sh

FILE='/home/alexesmet/Documents/Timetrack/timesheet.time'
IN_COMMAND=''

while :; do
    case $1 in
        -c|--command)
            IN_COMMAND='1'
            ;;
        --file=?*)
            FILE=${1#*=}
            ;;
        --file=)
            printf 'ERROR: "--file" requires a non-empty option argument.\n' >&2
            exit 1
            ;;
        --)
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)
            break
    esac

    shift
done


COMMAND="while clear; timesheet-generator '$FILE' | worked-today --expected 8; do inotifywait -q -e close_write '$FILE'; done"

if [ ! -z "$IN_COMMAND" ]; then
    sh -c "$COMMAND"
else 
    alacritty --class Alacritty,Pseudo \
        -o window.dimensions.lines=27 \
        -o window.dimensions.columns=42 \
        --command /usr/bin/sh -c "$COMMAND"
fi
