#!/usr/bin/perl

# ------------------------------------------------------------
# epochtime.pl
# ------------
# from devdaily.com
# a perl script to convert Nagios "epoch time" (epoch seconds)
# into a human-readable format.
# ------------------------------------------------------------

$num_args = $#ARGV + 1;
die "Usage: this-program epochtime (something like '1219822177')" if
($num_args != 1);

$epoch_time = $ARGV[0];

($sec,$min,$hour,$day,$month,$year) = localtime($epoch_time);

# correct the date and month for humans
$year = 1900 + $year;
$month++;

printf "%02d/%02d/%02d %02d:%02d:%02d\n", $year, $month, $day, $hour, $min, $sec;
