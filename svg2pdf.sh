#!/bin/bash
# Created: Saturday, January 17 2015
# sudo apt-get install librsvg2-bin
for f in "$@"; do
    rsvg-convert -f pdf -o "${f%.[^.]*}".pdf ${f}
done
