#!/bin/bash
#
#    File: foredir.sh
#  Author: Yagnesh Raghava Yakkala <hi@yagnesh.org>
# Created: Friday, April  8 2011

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
