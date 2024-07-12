#!/usr/bin/sh

for SOURCE in $(wpctl status \
    | awk -v RS='' 'NR==2' \
    | awk '/Sources/,/Streams/' \
    | rg ' (\d+). ' -o -r '$1')
do
    wpctl set-mute $SOURCE toggle
done

echo "change" >> /var/tmp/microphone-fifo;
notify-send -c device  -r 84161323 "Microphone $(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | rg '\[.+\]' -o || echo unmuted)"
