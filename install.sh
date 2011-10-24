#!/usr/bin/env perl
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
# Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Licence: GPL v3 or later
# date: 2011-04-17 15:03
# Description

# installs ubuntu package and tells puts package name in the apps file
# to have trace next fresh installations

use strict;
use warnings;

# config
our $AppsFileDir = "~/git/org/linux";
our $AppsFile = "apps";
my $wrong_args = 64;

if (@ARGV < 1 ) {
  print "USAGE: $0 <packagename(s)>:\n";
  exit $wrong_args;
}

sub append_to_appfile {
  print $AppsFileDir,"\n";
  open(my $dh, $AppsFileDir) or return "cant open $AppsFileDir $!";
  chdir($dh_hl)
  system('pwd');
  print "i am here";
}

sub install_app {
  my @in_cmd = ('echo','sudo','apt-get','install','-y');
  # my @in_cmd = ('sudo','apt-get','install','-y');
  my ($App) = @_;
  append_to_appfile($App) if system(@in_cmd,$App ) == 0;
}

foreach my $x (@ARGV) {
  install_app($x);
}

# install ends here
