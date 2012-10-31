#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: foredir.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Friday, April  8 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description:
# It just goes to subdirectory (depth to 1)

Args=$@
PWD=`pwd`


for Dir in `find $PWD -maxdepth 1 -type d` ; do
    cd $Dir
    echo
    echo "-------------------------------------------"
    echo "Entered into: `pwd`"
    echo "Running $Args"
    $Args
    echo
done

# foredir.sh ends here
