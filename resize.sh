#!/bin/bash
#any image file will be converted to thumb nail size

function usage() {
        echo USAGE: "$1 <web/ppt> <file name> "
}

function split-path () {
fullpath=$@

    filename="${fullpath##*/}"                      # Strip longest match of */ from start
    dir="${fullpath:0:${#fullpath} - ${#filename}}" # Substring from 0 thru pos of filename
    base="${filename%.[^.]*}"                       # Strip shortest match of . plus at least one non-dot char from end
    ext="${filename:${#base} + 1}"                  # Substring from len of base thru end
    if [[ -z "$base" && -n "$ext" ]]; then          # If we have an extension and no base, it's really the base
        base=".$ext"
        ext=""
    fi

}

MINARGS=2
E_ARGCOUNT=65

if [ $# -lt $MINARGS ]
then
    echo "${#} arguments."
    usage $0
    exit $E_ARGCOUNT;
fi

arg1=$1;			# option
shift;
arg2=$@				# filename
JPG-TYPE=jpg			# if output jpg

split-path $arg2
cd ${dir:-.}
pwd

case $arg1 in
    web)
	if [ -f ${base}.${ext} ]; then
	    echo "creating web thumb for ${filename}"
	    convert -thumbnail 250 ${base}.${ext}  ${base}.thumb.${ext}
	    echo " created ${base}.websize.${ext}"
	else
	    echo "'$1' is not a valid file"    
	fi
	;;

    ppt)
	if [ -f ${base}.${ext} ]; then
	    echo "creating ppt size for ${filename}"
	    convert -thumbnail 200 "${base}.${ext}"  "${base}.pptsize.${ext}"
	    echo " created ${base}.pptsize.${ext}"
	else
	    echo "'$1' is not a valid file"    
	fi
	;;
    hui*)
	if [ -f ${base}.${ext} ]; then
	    echo "creating Thumbnail for ${filename}"
	    convert -thumbnail 500 "${base}.${ext}"  "${base}.pptsize.${JPG-TYPE}"
	    echo " created ${base}.huisa.${JPG-TYPE}"
	else
	    echo "'$1' is not a valid file"    
	fi
    *)
    usage $0
    ;;
    
esac
