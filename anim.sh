#!/bin/bash
#    File: anim.sh
# Created: Wednesday, May 11 2011

# link
base="${1%.[^.]*}"
ext="${1:${#base} + 1}"

echo base=$base , ext=$ext

rm -i out.mp4

x=1;
for i in $@;
do
    counter=$(printf %04d $x);
    ln -sf $(pwd)/"$i" /tmp/img"$counter"."$ext";
    x=$(($x+1));
done

# make movie
avconv -f image2 -i /tmp/img%03d.jpg out.mp4

rm /tmp/img*.$ext
# anim.sh ends here
