#!/bin/bash
#    File: ubu-disk-clean.sh
# Created: Monday, October 17 2011

# auto remove
sudo apt-get autoclean
sudo apt-get clean
sudo apt-get autoremove

# orphaned packages
sudo deborphan | xargs sudo apt-get -y remove --purge

aptitude -F %p search '~c' | xargs sudo dpkg -P
# sys_clean.sh ends here
