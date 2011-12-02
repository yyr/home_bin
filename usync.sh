#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: usync.sh
# Created: Thursday, December  1 2011
# License: GPL v3 or later.  <http://www.gnu.org/licenses/gpl.html>
#

# Description:
Lubu=okhotsk19.lowtem.hokudai.ac.jp
Lpy=raghava-note.lowtem.hokudai.ac.jp

MinArgs=1

if [[ $# < $MinArgs ]]; then
    echo USAGE: $0 folder
    exit $MinArgs
fi

uname=$(whoami)

counter=0
while [ $counter -le $# ]; do
    echo
    echo "----- unison running on folder:    $1  -----"
    echo
    case `hostname` in
        raghava* )
            echo call: unison $1 ssh://$uname@$Lubu//$1
            unison $1 ssh://$uname@$Lubu//$1
            ;;
        okho* )
            echo call: unison $1 ssh://$uname@$Lpy//$1
            unison $1 ssh://$uname@$Lpy//$1
            ;;
        * )
            echo "not the hostname I am aware of"
            exit 128
            ;;

    esac
    shift
    let counter=counter+1
done


# usync.sh ends here
