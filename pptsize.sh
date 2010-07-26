
#!/bin/bash

#any image file will be converted to thumb nail size

function usage() {
        echo USAGE: "$1 <file name> "
}

   if [ $# -lt 1 ]
   then
    echo "${#} arguments."
    	usage webthumb
    	return 1
   fi
 

for fullpath in "$@" ; do

    filename="${fullpath##*/}"                      # Strip longest match of */ from start
    dir="${fullpath:0:${#fullpath} - ${#filename}}" # Substring from 0 thru pos of filename
    base="${filename%.[^.]*}"                       # Strip shortest match of . plus at least one non-dot char from end
    ext="${filename:${#base} + 1}"                  # Substring from len of base thru end
    if [[ -z "$base" && -n "$ext" ]]; then          # If we have an extension and no base, it's really the base
        base=".$ext"
        ext=""
    fi
    
    echo $filename
    echo $dir
    echo $base
    echo $ext

cd ${dir:-.}
pwd

if [ -f ${base}.${ext} ]; then
    echo "creating Thumbnail for ${filename}"
    convert -thumbnail 200 "${base}.${ext}"  "${base}.pptsize.${ext}"
    echo " created ${base}.thumb.${ext}"
else
    echo "'$1' is not a valid file"    
fi

done