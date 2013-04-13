#!/bin/sh
echo "Nightly Backup Started: $(date)" >> /var/log/mirror_backup.log

rsync -azXS --exclude=.gvfs --delete /home/ /backup/home/
rsync -azXS --delete /dump/ /backup/dump/

echo "Nightly Backup Successful: $(date)" >> /var/log/mirro_backup.log
