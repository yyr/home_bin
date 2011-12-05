#!/bin/bash
#******************************************************************************
# Author: Yagnesh raghava  Yakkala
# DATE: 2010-06-21
# Purpose: calculates the time to finish a script.
#
#
# Current Version:
# Latest change by on
#..............................................................................

echo "starting .. TICK.. TICK.."
echo "..."
echo "....."
START=$(date +%s.%N)
# do something
$@
END=$(date +%s.%N)
echo ""
echo " //// STOP \\\\\\\\"

DIFF=$(echo "$END - $START" | bc)
echo "It took ** ${DIFF:-failed to measure time} ** seconds"
