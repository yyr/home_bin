#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: rrsync.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Tuesday, May 10 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description:

Amu=amur.porc.lowtem.hokudai.ac.jp
Lubu=okhotsk19.lowtem.hokudai.ac.jp
Lpy=raghava-note.lowtem.hokudai.ac.jp
Dir=`pwd`
Dir="$Dir/"
Rsync=rsync
rsync_cmd="$Rsync -e ssh -vaurP --stats  --progress  "

MinArgs=1

# if [ $# < $MinArgs ]; then
#     echo USAGE: $0 <amu/lpy/amu>
# fi

case `hostname` in
    raghava* )
        $rsync_cmd $Dir $Lubu:$Dir
        $rsync_cmd $Lubu:$Dir $Dir
        ;;
    okho* )
        $rsync_cmd $Dir  $Lpy:$Dir
        $rsync_cmd $Lpy:$Dir $Dir
        ;;
    amur* )
        $rsync_cmd $Dir $Lubu:$Dir
        $rsync_cmd $Lubu:$Dir $Dir
        ;;
    * )
        echo "not the hostname I am aware of"
        ;;

esac

# rrsync.sh ends here
