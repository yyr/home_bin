#!/usr/bin/env perl
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: foredir.pl
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Friday, April  8 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description:
#
use strict;
use warnings;

# See http://search.cpan.org/~rclamp/File-Find-Rule-0.32/README
use File::Find::Rule;

# If a base directory was not past to the script, assume current working director
my $base_dir = shift // '.';
my $find_rule = File::Find::Rule->new;

# Do not descend past the first level
$find_rule->maxdepth(1);

# Only return directories
$find_rule->directory;

# Apply the rule and retrieve the subdirectories
my @sub_dirs = $find_rule->in($base_dir);

# Print out the name of each directory on its own line
print join("\n", @sub_dirs);


# Sources:
# http://stackoverflow.com/questions/205159/how-do-i-get-a-directory-listing-in-perl

# foredir.pl ends here
