#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: build-git.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Saturday, May  7 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description:
repo_dir=/home/yagnesh/git/repos/git

cd $repo_dir
sudo apt-get build-dep git-core git-doc
./configure --prefix=/home/yagnesh/local/git --with-curl=/usr/bin/curl EXPATDIR=/usr/

make all doc # remove doc for less dependencies
make install install-doc install-html

# build-git.sh ends here
