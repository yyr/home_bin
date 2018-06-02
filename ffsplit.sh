#!/bin/bash
# Created: Friday, February  9 2018
echo ffmpeg \
     -y -i "${1}" \
     -vcodec copy \
     -acodec copy \
     -ss ${2}  -to ${3} \
     -sn ${4}

time ffmpeg \
     -y -i "${1}" \
     -vcodec copy \
     -acodec copy \
     -ss ${2}  -to ${3} \
     -sn ${4}
