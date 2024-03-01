#!/usr/bin/sh
bluetoothctl power off
rfkill block bluetooth
rfkill unblock bluetooth
systemctl start bluetooth
sleep 1
bluetoothctl power on
exit 0
