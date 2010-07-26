#!/bin/bash
#******************************************************************************|
# Author: Yagnesh raghava  Yakkala                                             |
# DATE: 2010-07-22
# Purpose: to get multiple file from server
# 
# Current Version: 0.1
# Latest change by on 2010-07-22 17:33
#..............................................................................!

if [ $# -lt 3 ]; then
        echo "Usage: $0 url_format seq_start seq_end [wget_args]"
        exit
fi

url_format=$1
seq_start=$2
seq_end=$3
shift 3

printf "$url_format\\n" `seq $seq_start $seq_end` | wget -i- "$@"
