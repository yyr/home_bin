#!/bin/sh

# ******************************************************************************|
#  Author: Yagnesh raghava  Yakkala                                             |
#  DATE:
#  Purpose:

#                                                                               |
#  Current Version:
#  Latest change by on 
# ..............................................................................!




# 	if ask "*************WARNING****************** \
# This program effects all the subfolders as well  \
# Do you want to continue  " 
    if ask this affects subfolders as well. continue? 
	then
	    continue 
	fi

	find . -name "* *"|while read file
	do
	    target=`echo "$file"|tr -s ' ' '_'`
	    mv "$file" "$target"
	done
