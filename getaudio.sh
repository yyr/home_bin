#!/bin/bash
# Created: Thursday, January 15 2015
# Usage: getaudio.sh 1.mp4 [2.mp4 ... 10.mp4]

for f in "$@"; do
    avconv -i "$f" -c copy -map 0:a "$f".mp4
done
