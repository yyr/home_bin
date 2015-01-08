#!/bin/sh

log_file="/var/log/mirror_backup.log"

t="$(date +%s)"
echo "$(date "+%F %H:%M:%S"): Mirroring Started." >> $log_file

rsync -azXS --exclude=.gvfs --delete /home/ /backup/home/
rsync -azXS --delete /dump/ /backup/dump/

t="$(($(date +%s)-t))"
printf "$(date "+%F %H:%M:%S"): Mirroring Finished. \nElapsed time: %02d:%02d:%02d\n" \
       "$((t/3600))" "$((t%3600/60))"  "$((t%60))"
