#!/bin/bash
# Created: Wednesday, April 16 2014

links=(http://journals.ametsoc.org/loi/bams
       http://journals.ametsoc.org/loi/atsc
       http://journals.ametsoc.org/loi/mwre
       http://journals.ametsoc.org/toc/wefo/current
       http://journals.ametsoc.org/loi/clim
       http://www.sciencedirect.com/science/journal/01698095
       http://agupubs.onlinelibrary.wiley.com/hub/jgr/journal/10.1002/%28ISSN%292169-8996/
       https://www.jstage.jst.go.jp/browse/jmsj
       http://www.atmos-chem-phys.net/volumes_and_issues.html
       http://link.springer.com/journal/382)

count=${#links[@]}
index=0
while [ "$index" -lt "$count" ]; do
    echo -e "$index: ${links[$index]}"
    let "index++"
done
echo "-1: forall links    <----"

echo  "Select #:"
read ans

if [ "$ans" -eq "$ans" ]; then
    if [ "$ans" -eq -1 ]; then
        for link in ${links[@]}; do
            firefox -url $link
        done
    else
        firefox -url ${links[$ans]}
    fi
fi
