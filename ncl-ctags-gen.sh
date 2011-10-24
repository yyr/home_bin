#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: ncl-ctags-gen.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@NOSPAM.live.com>
# Created: Monday, October 24 2011
# License: GPL v3 or later.  <http://www.gnu.org/licenses/gpl.html>
#

# Description:

ctags-exuberant -e -a --verbose=yes  --langdef=ncl \
    --langmap=ncl:.ncl --regex-ncl='/^[[:space:]]*function[[:space:]]+(.*)/\1/f,function/' *.ncl \
    --regex-ncl='/^[[:space:]]*procedure[[:space:]]+(.*)/\1/p,procedure/' `find . -type f -name "*.ncl"`

# ncl-ctags-gen.sh ends here
