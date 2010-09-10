#!/bin/bash
#---------------------------------------------------------------------------
# Author: yagnesh raghava yakkala  Email: yagneshmsc@NOSPAMgmail.com
# DATE: 2010-09-11
# Purpose: this removes all spaces from filenames contained in a folder
# 
# Current Version: 0.1
# Latest change by YYR on 2010-09-11 00:36
#---------------------------------------------------------------------------

find . -maxdepth 1|while read file
do
    target=`echo "$file"|tr -s ' ' '_'`
    mv "$file" "$target"
done
