#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: buildemacs.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Tuesday, March 22 2011 
#
# Description: 

function check_error() {
    if [[ $? != 0 ]] ; then
	echo "Error!! =>  $1"
	exit 100;
    fi
    
}

function run_autogen() {	# run autogen.sh
    if [ $Hostname == "amur" ]; then
	autoreconf -I m4
    else
	./autogen.sh > autogen.log 2> autogen.log &
    fi
    check_error "autogen"
}

function get_flags() {		# any flags (changes from system to system)
    case $Hostname in
	amur )
	    conf_flags=' --with-jpeg=no --with-gif=no --with-tiff=no'
	    ;;
	* )
	    conf_flags=""
	    ;;
    esac
}

function run_configure() {
    ./configure --prefix=$install_dir $conf_flags
    check_error "configure"

}

function run_make() {
    $Make clean
    $Make $Bootstrap
    check_error "Make"
}

function back_up() {
    if [ -d $install_dir ]; then
	if [ -d $backup_dir]; then
	    rm -r $backup_dir
	fi
	mv $install_dir  ${backup_dir}
    fi
}

function make_install() {
    $make install
}


repo_dir=~/git/repos/emacs
Uname=`whoami`
install_dir=/home/$Uname/local/emacs-git
backup_dir=/home/$Uname/local/emacs-backup


cd $repo_dir


Hostname=`hostname`
Make=make
Bootstrap=bootstrap


run_autogen
get_flags
run_configure
run_make
back_up
make_install


# buildemacs.sh ends here
