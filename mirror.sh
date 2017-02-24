#!/bin/sh

log_file="/var/log/mirror_backup.log"

t="$(date +%s)"
printf "$(date +"%F"): Mirroring started at $(date +"%r") --> " >> $log_file

rsync --delete -azXS --exclude=.gvfs /home/ /dump/home/
# rsync -azXSv lap:/home/yagnesh/works/ /home/yagnesh/works/

t="$(($(date +%s)-t))"
printf "Finished at $(date +"%r"). Elapsed time: %02d:%02d:%02d\n" \
       "$((t/3600))" "$((t%3600/60))"  "$((t%60))" >> $log_file
