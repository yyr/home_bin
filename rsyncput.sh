#! /bin/bash


# ******************************************************************************|
#  Author: Yagnesh raghava  Yakkala                                             |
#  DATE: 2010-06-16
#  Purpose: this is to syncronize a directory to destinated remote/local directory
#  put if file not available , log them into copied log , with a time stamp
#  if the same file is present check the file size, file size is same just update time
#  size is different prepare a log for those confilicting files with time stamp
#  read from ignore file to ignore in coping.

#                                                                               |
#  Current Version:
#  Latest change by on 2010-06-16 19:27
# ..............................................................................!


#### var dictionary
#
#
#
#

soucedir=
destdir=

# Example script to mirror the home directory for a user to a server via
# rsync over SSH.

# for copy to $HOME/backup/$SHORTHOST directory on server
SHORTHOST=`hostname | awk 'BEGIN { FS="." } { print $1 }'`

cd $HOME || exit 1
rsync -v --delete --delete-excluded --exclude-from=$HOME/.rsync/exclude \
  --timeout=999 -az \
  -e 'ssh -c blowfish -i .ssh/backup -ax -o ClearAllForwardings=yes' \
  $HOME/ server:backup/$SHORTHOST


#rsync -az -e ssh --delete ip_addr:/home/public /home/local


#rsync -vauz –delete –rsh=ssh –stats music username@server.address.com:/home/username/musicbackup/

#rsync -vauz –delete –rsh=ssh –stats username@server.address.com:/home/username/musicbackup /home/username/music/