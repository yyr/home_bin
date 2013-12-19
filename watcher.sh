#!/bin/bash
# http://serverfault.com/a/436739

FILE="$1"
CMD="$2"
LAST=`ls -l "$FILE"`
while true; do
    sleep 1
    NEW=`ls -l "$FILE"`
    if [ "$NEW" != "$LAST" ]; then
        t="$(date +%s)"
        echo "watcher action started at "  $(date)
        "$CMD" 2>&1 | tee /tmp/wathcer.log.$$
        LAST="$NEW"
        t="$(($(date +%s)-t))"
        printf "done; %02d:%02d\n" "$((t/60%60))" "$((t%60))"
    fi
done
