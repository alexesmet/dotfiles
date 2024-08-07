cat ~/Documents/Timetrack/timesheet.time |
    awk "/$(date -I)/,/$(date -I -d tomorrow)/" |
    grep '^# \*' |
    sd '^# \*' '*' |
    sd '(CC[A-Z]-\d{2,6})' '[$1](https://carbonclick.atlassian.net/browse/$1)' |
    sed '1i Today I:' |
    tee /tmp/today-i.md |
    xclip -sel clip && clear && bat -p -l markdown /tmp/today-i.md
