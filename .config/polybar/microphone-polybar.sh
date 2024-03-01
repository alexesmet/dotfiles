#!/usr/bin/sh

PIPE='/var/tmp/microphone-fifo'

if [ ! -p $PIPE ]
then
    mkfifo $PIPE
fi

case "$1" in
    "--toggle" )

    ;;
    *)
        while
            case "$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)" in 
                *MUTED* ) echo "%{F#f43753}";;
                * ) echo ""
            esac
            cat $PIPE >> /dev/null  
        do true
        done
    ;;
esac

