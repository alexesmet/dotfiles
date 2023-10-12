#!/bin/sh

if [ -z "$1" ]
then
    timesheet-generator
else
    timesheet-generator "$1"
fi | awk -F, '
NR>1 {
    arr[$1] += $3
    sum += $3
} 
END { 
    n = asorti(arr, sorted)
    for (i=1; i<=n; i++) {
        print sorted[i] " = " arr[sorted[i]]
    }
    print "     Total = " sum 
}
'



