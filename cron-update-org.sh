#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: cron-update-org.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Saturday, August 27 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description:

org_fold="~/.emacs.d/el-get/org-mode"

function self-clean() {
    rm -f pull.log
}

function check_error() {
    if [[ $? != 0 ]] ; then
        echo "Error!! =>  $1"
        exit 100;
    fi

}

function master-pull () {
    git co master
    git pull --rebase > pull.log
}

cd org_fold;
master-pull
make

# cron-update-org.sh ends here
