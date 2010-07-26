#!/bin/bash
#
usage()
{
        echo "Usage: $0 [directory]"
        exit 1;
}

test -d "$1" || usage

dir="$1"

ls $dir | grep -e "[:alnum:]" | \
while read i; do
j=`echo -n "$i" | sed -e 's/ /_/'`
echo mv "$dir/$i" "$dir/$j"
done