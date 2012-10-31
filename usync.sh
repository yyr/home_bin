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

function usage()
{
        cat <<EOF
USAGE:
       $0 -options folder
Options:
          -i run unison interactively
EOF
}

if [[ $# < $MinArgs ]]; then
    usage
    exit $MinArgs
fi

unison="unison -batch"

uname=$(whoami)

counter=0
while [ $counter -le $# ]; do
    case $1 in
        -i)
            unison=unison
            shift
            ;;
        *)
            echo
            echo "----- unison running on folder:    $1  -----"
            echo
            case `hostname` in
                raghava* )
                    echo call: unison $1 ssh://$uname@$Lubu//$1
                    ${unison} $1 ssh://$uname@$Lubu//$1
                    ;;
                okho* )
                    echo call: unison $1 ssh://$uname@$Lpy//$1
                    ${unison} $1 ssh://$uname@$Lpy//$1
                    ;;
                * )
                    echo "not the hostname I am aware of"
                    exit 128
                    ;;
            esac
            shift
            ;;
    esac
    let counter=counter+1
done

# usync.sh ends here
