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

case `hostname` in
    raghava* )
        unison $1 ssh://$uname@$Lubu//home/yagnesh/$1
        ;;
    okho* )
        unison $1 ssh://$uname@$Lpy//home/yagnesh/$1
        ;;
    * )
        echo "not the hostname I am aware of"
        exit 128
        ;;

esac


# usync.sh ends here
