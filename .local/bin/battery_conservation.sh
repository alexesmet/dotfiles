#!/bin/bash

function print_help() {
            printf "\
Usage: battery-conservation [OPTION]\n\
\n\
Options:\n\
    -h  Print help information.\n\
    -n  Turn battery conservation on.\n\
    -f  Turn battery conservation off.\n\
    -s  See battery conservation status.\n"
}

file_path="/sys/bus/platform/drivers/ideapad_acpi/VPC2004*/conservation_mode"

while getopts 'hsnf' OPTION
do
    case "$OPTION" in
        h)
            print_help
            exit 0
            ;;
        s)
            status=$(bash -c "cat $file_path")

            if [ "$status" = "0" ]; then
                echo "Off"
            elif [ "$status" = "1" ]; then
                echo "On"
            else
                echo "Unknown"
            fi

            exit 0
            ;;
        n)
            sudo bash -c "echo 1 > $file_path"
            exit 0
            ;;
        f)
            sudo bash -c "echo 0 > $file_path"
            exit 0
            ;;
        ?)
            print_help
            exit 1
            ;;
    esac
done

print_help
exit 1