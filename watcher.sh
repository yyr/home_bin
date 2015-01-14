#!/bin/bash
# http://stackoverflow.com/a/9461685

FILE="$1"
shift;
CMD="$@"

function daemon() {
    chsum1=""
    while [[ true ]]
    do
        chsum2=`find $1 -type f -and -not -path "./.git/*" -exec md5sum {} \;`
        if [[ $chsum1 != $chsum2 ]] ; then
            t="$(date +%s)"
            eval "$2" 2>&1 | tee /tmp/wathcer.log.$$
            chsum1=$chsum2
            t="$(($(date +%s)-t))"
            printf "\nElapsed time: %02d:%02d\n" "$((t%3600/60))"  "$((t%60))"
        fi
        sleep 1
    done
}
daemon $FILE $CMD
