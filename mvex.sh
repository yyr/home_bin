#!/bin/bash
#
#this program looks for excutables in the given directory
#and move them to given directory (probably $home/bin)
#
# Usage : mvex sourcedir destinationdir
# if Destination dir is not given., excutables will move into $HOME/dir
#
. $HOME/libs/lyesno

#setting the source directory variable from which excutable has to move
#
sodir=$1
desdir=$2
i=0

#if destination is not given below line does the work
[ "$desdir" = "" ] && desdir=$HOME/bin

#checking the files coming in, & excutable will be movied
for fname in $sodir/*
do
  if [ -d $fname ]  # directory checking
      then
      continue;
  elif [ -f $fname ]
      then
      [ -x $fname ] && # yesno do you want to move $fname to $desdir &&
	mv $fname $desdir && ((i++)) # if excutable, file will be moved
  fi
done

echo "$i file(s) moved"
