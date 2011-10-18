#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: publish-yorg.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Sunday, August  7 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description:

sitedir=~/git/sites/yorg/org/

function remove-cache() {
    cd ~/
    rm -rf ~/.org-timestamps/
}

function publish() {
    cd $sitedir
    make
}

case $1 in
    rc )
        remove-cache
        publish
        ;;
    * )
	publish
        ;;
esac


# publish-yorg.sh ends here
