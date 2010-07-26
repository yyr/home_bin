#!/bin/bash
#   1. ONLY convert the files in the directory where this script is.
#   2. “¡°-density 150“¡È is the resolution, in this case 150 dpi
#   3. -geometry 100% is the scale you want to resize by %
#   4. also, you can convert lots of JPEG to smaller resolution,
# just change .ps to .jpg, and change the output to another directory, either using .jpg or .png

########################
## using "convert" from ImageMagick to do ps convert into PNG
#########################

nof=`ls $* |wc -l`

index=0
echo "total files: $nof"

echo PS convert to PNG, please wait the process
for INP in $* #.ps
do
  newname=`basename $INP .ps`
  convert -density 165 -rotate 270 -geometry 100% $INP $newname%02d.png
  echo "convert $INP to $newname.png completed"
  index=$(($index+1))
  echo "$index over out of $nof"
done

echo "process completed"
echo "total $nof postscript files are converted into png format"
echo "please check your graphical files"
