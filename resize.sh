#!/bin/bash
#any image file will be converted to thumb nail size

THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/blib.sh

function usage() {		# tell the usage
        echo USAGE: "$1 <web/ppt> <file name> "
}

function convert-this-file() {	# convert to desired format
    cd ${dir:-.}
    case $1 in
	web)
	    if [ -f ${base}.${ext} ]; then
		echo "creating web thumb for ${filename}"
		convert -thumbnail 350 "${base}.${ext}"  "${base}.websize.${ext}"
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
		convert -thumbnail 800 "${base}.${ext}"  "${base}.800.${IMG}"
		echo " created ${base}.800.${IMG}"
	    else
		echo "'$1' is not a valid file"
	    fi
	    ;;

	* )
	    usage $0
	    # exit $WRONG_OPTION
	    ;;
    esac

}

MINARGS=2
E_ARGCOUNT=65
WRONG_OPTION=420

if [ $# -lt $MINARGS ]
then
    echo "${#} arguments."
    usage $0
    exit $E_ARGCOUNT;
fi

arg1=$1;			# option
shift;
in_files=$@				# filename
cwd=`pwd`
IMG=jpg			# for specific image type


for file in $in_files; do
    split-path $file
    convert-this-file $arg1
done
