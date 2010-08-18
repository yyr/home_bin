#!/bin/bash
#******************************************************************************|
# Author: Yagnesh raghava  Yakkala                                             |
# DATE: 2010-07-22
# Purpose: to update org install

# Current Version: 0.1
# Latest change by on 2010-07-22 14:45
#..............................................................................!

ORGDIR="$HOME/git/org-mode"
INFODIR="$HOME/git/info/"
MAKEINFO="makeinfo"

cd $ORGDIR
git pull && make clean && make && make doc && sudo make install

# make clean &&
# git pull &&
# make > /dev/null &&
# make doc /dev/null &&
# sudo make install
make clean > /dev/null && 

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

cd doc/
$MAKEINFO --output="$INFODIR/org.info" org.texi && echo "org.info is in $INFODIR"

