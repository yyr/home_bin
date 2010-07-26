#!/bin/bash

# ******************************************************************************|
#  Author: Yagnesh raghava  Yakkala                                             |
#  DATE:2010-06-17
#  Purpose: this brings same file from different server , before rewriting it 
#           puts a back up with time stamp.
#                                                                               |
#  Current Version:
#  Latest change by on 2010-06-17 17:07
# ..............................................................................!

#var dict


### Functions ---------------------------------------------

function usage() {     # let the user know how to use this
    echo USAGE: "$1 <what> <from where>"
}

function ask()          # for conformation from user interactively
{
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}

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


### CODE STARTS HERE ---------------------------------------

### verification of number of args

ARGCOUNT=2
E_ARGCOUNT=65

if [ $# -ne $ARGCOUNT ]
then
    echo "${#} arguments."
    usage bring.sh
    exit $E_ARGCOUNT
fi

### split the directory and filename

FULLPATH=$1
SERVER_nick=$2

### split the given name for GOD sake
splitpath $FULLPATH

cd ${DIR:-$PWD}
DIR=$PWD # solves calling half folder problem

#pwd

case $SERVER_nick in
    labu*)
	SERVER=okhotsk19.lowtem.hokudai.ac.jp
	;;
    sup)
    	    SERVER=bu3107@wine.hucc.hokudai.ac.jp
    	    ;;
    lap*)
	SERVER=raghava-note.lowtem.hokudai.ac.jp
	;;
    kor)
	SERVER=korsakov.porc.lowtem.hokudai.ac.jp
	;;
    *)
	echo "ERROR: UNKNOWN SERVER"
	exit 1
	;;
esac

### check whether asking for same system
if [     $( echo $SERVER | awk -F. '{print $1}') == $(hostname | awk -F. '{print $1}') ]; then
	echo " LOL!!!! SAME SYSTEM" ;exit 1    
fi

### user name for sup
if [  $SERVER_nick == sup ]; then
    USER=bu3107
    DIR=$(echo $DIR | sed 's/yagnesh/bu3107/')
    echo $DIR
else
    USER=yagnesh    
fi

### check the file exists locally, back up if so.
if [  -f $FILENAME ]; then
   echo "      $FULLPATH **EXISTS** onlocal machine:-)."
   cp $FILENAME $FILENAME.$(date +"%y%m%d%H")
   echo "backed up $FULLPATH.$(date +"%y%m%d%H") " 
   echo
else
    echo "locally file does not EXIST no need to back up"
    echo 
fi

### action
if [  -n `'ssh' $USER@$SERVER 'ls' ${DIR}/$FILENAME ` ]; then
    echo "file **EXISTS** on $SERVER_nick as well :-)"  
   scp $USER@$SERVER:${DIR:-${PWD}}/$FILENAME  . 
    (( $? == 0 )) && echo " BROUGHT **$FILENAME** to ${DIR:-THIS FOLDER}"  && \
	echo "Brought ** $FILENAME** from $SERVER on $(date)" >> .exchagne.log # logging.
else
    echo "NOT EXISTS on SERVER "
    exit 127
fi

exit 0
