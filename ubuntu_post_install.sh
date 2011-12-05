#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: ubuntu_post_install.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@NOSPAM.live.com>
# Created: Tuesday, October 18 2011
# License: GPL v3 or later.  <http://www.gnu.org/licenses/gpl.html>
#

# Description:

apps_file=~/git/org/linux/apps

function install_apps () {
    for a in `cat $apps_file ` then;
    do

        echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
        echo ----------------- $a  --------------;
        echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
        echo ;
        sudo apt-get install -y $a;
        echo ------------------------------------------------------;
        echo ;
        echo ;

    done
}

install_apps
# ubuntu_post_install.sh ends here
