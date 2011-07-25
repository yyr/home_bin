#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: ferret_install.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Monday, May  9 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description:
Fdata_dir=~/DATA/fer_dsets/
src_dir=~/src/ferret
install_dir=~/local/ferret

ftp_url=ftp://ftp.pmel.noaa.gov/ferret/pub/x86_64-linux_nc4
ftp_url_data=ftp://ftp.pmel.noaa.gov/ferret/pub/data/

src_env=fer_environment.tar.gz
src_exe=fer_executables.tar.gz
src_data=fer_dsets.tar.gz

function make_dir () {
    for dir in $@; do
        if [ ! -d $dir ]; then
            mkdir -p $dir
        fi
    done
}

function download_src() {
    for file in $@ ; do
        if [ ! -f $file ]; then
            wget $ftp_url/$file
            wget $ftp_url_data/$file
        fi
    done
}

make_dir $Fdata_dir $src_dir $install_dir
cd $src_dir
download_src $src_env $src_exe $src_data

# place environments
cd $install_dir
tar xzf $src_dir/$src_env

# place datasets
cd $Fdata_dir
tar xzf $src_dir/$src_data

# install ferret
# some paths
export FER_DIR=$install
export FER_DSETS=$Fdata_dir
export ferexec_dir=$src_dir
export SHELL=/bin/bash

$install_dir/bin/Finstall

# ferret_install.sh ends here
