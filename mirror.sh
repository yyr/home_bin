#!/bin/sh
rsync -az --exclude=.gvfs --delete /home/ /backup/home/
rsync -az --delete /dump/ /backup/dump/

echo "Nightly Backup Successful: $(date)" >> /tmp/mybackup.log
