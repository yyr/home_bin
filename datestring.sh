#!/bin/sh
# modify "S*L2" to match filename pattern of SeaWiFS files
# Example filename: S1999365235959.L2
for NAME in S*L2
do
  YYYY=`echo $NAME |cut -c2-5`
  DDD=`echo $NAME |cut -c6-8`

  datestring=`$SEADAS/bin/jd2date $DDD $YYYY`
  month=`echo $datestring |cut -c1-2`
  day=`echo $datestring |cut -c3-4`
  pngfile=${day}${month}${YYYY}.png
  echo $pngfile
done 