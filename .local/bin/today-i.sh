F="$HOME/Documents/Timetrack/timesheet.time"
L=$(cat $F | awk "/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/{ n=NR } END { print n } ")

cat $F |
    sd '^([0-9]+[mh] )+(.+)$' '@###@ $2' |
    awk "/^(\w{2,5}-[0-9]{1,6}|--)$/ { l = \$0 } NR>$L && /^@###@/ { print l \" - \" \$0 }" |
    sd '@###@ *' '' |
    sd '^-- - ' '' |
    sd '(\w{2,5}-[0-9]{1,6})' '[$1](https://carbonclick.atlassian.net/browse/$1)' |
    grep -v "^$" |
    awk '{print "* " $0}' |
    sed '1i Today I:' |
    tee /tmp/today-i.md |
    xclip -sel clip && clear && bat -p -l markdown /tmp/today-i.md
