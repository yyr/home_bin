#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: ubu-disk-clean.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@NOSPAM.live.com>
# Created: Monday, October 17 2011
# License: GPL v3 or later.  <http://www.gnu.org/licenses/gpl.html>
#

# Description:

# auto remove
sudo apt-get autoclean
sudo apt-get clean
sudo apt-get autoremove

# orphaned packages
sudo deborphan | xargs sudo apt-get -y remove --purge

# computer janitor

# ubu-disk-clean.sh ends here
