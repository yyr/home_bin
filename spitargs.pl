#!/usr/bin/env perl
#
#  Description: Spits out command line arguments to show what the
#   shell thinks are separate option words.
#  Source: ubuntuforums.org

use strict;

foreach my $arg (@ARGV) {
    print "arg <$arg>\n";
}
