#!/bin/bash
# Created: Monday, June 24 2013
# unfinished

fullpath=$1

# split path
filename="${fullpath##*/}"
dir="${fullpath:0:${#fullpath} - ${#filename}}"
base="${filename%.[^.]*}"
ext="${filename:${#base} + 1}"
if [[ -z "$base" && -n "$ext" ]]; then
    base=".$ext"
    ext=""
fi

fileagainstdir="${fullpath%%${#stddir}}"
outfile=${base}-signed.${ext}

#
convert -composite -gravity $filename signature.png $outfile
