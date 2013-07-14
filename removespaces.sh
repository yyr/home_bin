#!/bin/bash
# DATE: 2010-09-11
# Purpose: this removes all spaces from filenames contained in a folder

find . -maxdepth 1 | while read file
do
    target=`echo "$file"|tr -s ' ' '_'`
    mv "$file" "$target"
done
