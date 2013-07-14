#!/bin/sh

log_file="/var/log/mirror_backup.log"

echo "Nightly Backup Started: $(date)" >> $log_file

rsync -azXS --exclude=.gvfs --delete /home/ /backup/home/
rsync -azXS --delete /dump/ /backup/dump/

echo "Nightly Backup Successful: $(date)" >> $log_file
