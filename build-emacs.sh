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

function yesno() {
    echo -n "$* (y/N)]?"; read yn junk
    case $yn in
        y|Y|yes|YES ) #true
            return 0
            ;;
        N|n|no|NO )  #false
            return 1
            ;;
        * )
            echo "Please answere [y/n]"
            ;;
    esac
}

function announce() {           # Annouce in the STDOUT
    echo "

$@

"
}

function error_convay () {
    echo "
ERROR: $@
"
}

function is_git_availble() {          # Checks for git excutables
    which git &> /dev/null
    if [ $? == 0 ]; then
        return 0
    else
        return $No_git_error
    fi
}


function git_update () {
    announce "running git update"
    is_git_availble
    if [ $? == $No_git_error ]; then
        error_convay "$No_git_error; Seems \"git \" is not available; will procede with out git update"
        return $No_git_error
    fi
    # git_reset
    # git_clean
    git checkout master
    git pull
}

function run_autogen() {        # run autogen.sh
    announce "running autogen.sh"
    if [ $Hostname == "amur" ]; then
        ./autogen/copy_autogen
    else
        ./autogen.sh &> autogen.log
    fi
    check_error "autogen"
}

function get_flags() {          # any flags (changes from system to system)
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
    announce 'Running: configure'
    ./configure --prefix=$install_dir $conf_flags &> conf.log
    check_error "configure"

}

function run_make() {
    # $Make clean &> /dev/null
    announce 'Running: make bootstrap'
    $Make $Bootstrap &> bootstrap.log
    # $Make &> make.log
    check_error "Make"
}

function back_up() {
    announce 'Running: backup'
    if [ -d $install_dir ]; then
        if [ -d $backup_dir ]; then
            rm -r $backup_dir
        fi
        mv $install_dir  ${backup_dir}
    fi
}


function make_install() {
    announce 'Runnig: make install'
    $Make install &> install.log
    check_error "installation"
}


#--------------------------------------------------------------
# code starts here

#Error returns
No_git_error=61


repo_dir=~/git/repos/emacs
Uname=`whoami`
install_dir=/home/$Uname/local/emacs-git
backup_dir=/home/$Uname/local/emacs-backup



cd $repo_dir

Hostname=`hostname`
Make=make
Bootstrap=bootstrap

git_update                      # pull from repo
run_autogen                     # run the autogen to prepare configure script
get_flags                       # look for any flags
run_configure                   # runn the configure script
run_make                        # make (make bootstrap)
back_up                         # backup old installation if any and remove old backups
make_install                    # install to the specified directory

# buildemacs.sh ends here
