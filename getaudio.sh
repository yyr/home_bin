#!/bin/bash
# Created: Thursday, January 15 2015
# Usage: getaudio.sh in.mp4 out.mp4

avconv -i "$1" -c copy -map 0:a "$2"
