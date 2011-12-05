#!/bin/bash
#
# ******************************************************************************
#  Author: Yagnesh raghava  Yakkala
#  DATE:2010-06-18
#  Purpose: split path and filename (extention as well)
#
#  Current Version:
#  Latest change by on 2010-06-18 10:20
# ..............................................................................

function splitpath()  # splits file name and folders
{
    FULLPATH=$1
    FILENAME="${FULLPATH##*/}"                      # Strip longest match of */ from start
    DIR="${FULLPATH:0:${#FULLPATH} - ${#FILENAME}}" # Substring from 0 thru pos of FILENAME
    BASE="${FILENAME%.[^.]*}"                       # Strip shortest match of . plus at least one non-dot char from end
    EXT="${FILENAME:${#BASE} + 1}"                  # Substring from len of BASE thru end
    if [[ -z "$BASE" && -n "$EXT" ]]; then          # If we have an extension and no BASE, it's really the BASE
        BASE=".$EXT"
        EXT=""
    fi
}

### Code starts

FILENAME=
DIR=
BASE=
EXT=

FULLPATH="$@"

splitpath $FULLPATH

echo "FILENAME=$FILENAME"
echo "     DIR=$DIR"
echo "    BASE=$BASE"
echo "     EXT=$EXT"
