#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: build-python.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Friday, June 24 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description:
#
#--------------User modifications------------------
py_ver=2.7.2
srcdir=~/src

installdir="/home/$(whoami)/local/python${py_ver}"
in_name="PYTHON"

py_dir="Python-$py_ver"
source_tar="Python-$py_ver.tgz"
down_url="http://www.python.org/ftp/python/$py_ver/$source_tar"

function build_dep () {
    sudo apt-get install build-essential libncursesw5-dev \
        libreadline5-dev libssl-dev libgdbm-dev libc6-dev libsqlite3-dev tk-dev
}

function build() {
    ./configure --prefix=$installdir
    make | tee $in_name.make.log
    make altinstall | tee $in_name.altinstall.log
}

function wget_down() {
    wget $down_url
    if [ $? != 0 ]; then
        return 0
    else
        return 24
    fi
}

# ------------------------------
cd $srcdir;
#build_dep
if [ ! -f $source_tar ]; then
    wget_down
    tar xvf $source_tar           # extract is bash function to extract the any compressed file
else
    tar xvf $source_tar           # extract is bash function to extract the any compressed file
fi



echo $srcdir/$py_dir
cd $srcdir/$py_dir

echo building: $py_ver
pwd
build



# build-python.sh ends here
