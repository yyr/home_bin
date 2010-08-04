#!/bin/bash
#******************************************************************************|
# Author: Yagnesh raghava  Yakkala                                             |
# DATE: 2010-07-22
# Purpose: to update org install

# Current Version: 0.1
# Latest change by on 2010-07-22 14:45
#..............................................................................!

# run as sudo
cd ~/git/org-mode/

make clean &&
git pull &&
make clean > /dev/null && 
make > /dev/null &&
make doc /dev/null &&
sudo make install

if [  $? == 0 ]; then
    echo "****************************************"
    echo "* ORG-MODE IS NOW SUCCESSFULLY UPDATED *"
    echo "****************************************"
else
    echo "****************************************"
    echo "             FAILED                     "
    echo "****************************************"
    exit 2
fi
