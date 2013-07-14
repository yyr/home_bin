#!/bin/bash
# Created: Tuesday, June 18 2013
# created to copy a damaged external hdd which is being unmounted automatically

rsync -azXSv --delete /media/SUNIL/ /backup/sunil/ &
PID=$!

while [ 1 ]
do
  sleep 2s
  kill -0 $PID
  is_rsync_running=$?

  if [ ! $is_rsync_running -eq 0 ]; then
      echo "restarting rsync"
      rsync -azXSv --delete /media/SUNIL/ /backup/sunil/ &
      PID=$!
  fi
done
