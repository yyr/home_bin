#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: fetch-thundermail.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@NOSPAM.live.com>
# Created: Sunday, October 23 2011
# License: GPL v3 or later.  <http://www.gnu.org/licenses/gpl.html>
#

# Description:

/usr/bin/alltray /usr/bin/thunderbird &
sleep 300 # 5 minutes
kill $!   # kill this script

# fetch-thundermail.sh ends here
