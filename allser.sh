#!/bin/bash

# ******************************************************************************|
#  Author: nixcraft modification by Yagnesh raghava  Yakkala                                             |
#  DATE: 2010-06-17
#  Purpose:

#                                                                               |
#  Current Version:
#  Latest change by on 2010-06-17 13:05
# ..............................................................................!



# Linux/UNIX box with ssh key based login
SERVERS="192.168.1.1 192.168.1.2 192.168.1.3"
# SSH User name
USR="jadmin"
 
# Email
SUBJECT="Server user login report"
EMAIL="admin@somewhere.com"
EMAILMESSAGE="/tmp/emailmessage.txt"
 
# create new file
>$EMAILMESSAGE
 
# connect each host and pull up user listing
for host in $SERVERS
do
echo "--------------------------------" >>$EMAILMESSAGE
echo "* HOST: $host " >>$EMAILMESSAGE
echo "--------------------------------" >>$EMAILMESSAGE
ssh $USR@$host w >> $EMAILMESSAGE
done
 
# send an email using /bin/mail
/bin/mail -s "$SUBJECT" "$EMAIL" < $EMAILMESSAGE