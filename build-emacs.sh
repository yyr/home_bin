#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: buildemacs.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Tuesday, March 22 2011
# Licence: GPL v3 or later
#

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
            conf_flags=' --with-jpeg=no --with-gif=no --with-tiff=no --without-gnutls'
            ;;
        * )
            conf_flags=" --with-gnutls=yes"
            ;;
    esac
}

function run_configure() {
    announce 'Running: configure'
    ./configure --prefix=$install_dir $conf_flags &> conf.log
    check_error "configure"

}

function run_make() {
    if [ ${1:-" "} = "clean"  ]; then
        announce 'Running: make bootstrap'
        $Make clean &> /dev/null
        $Make $Bootstrap &> bootstrap.log
    else
        announce 'Running: make'
        $Make &> make.log
    fi
    check_error "Make"
}

function back_up() {        # backup old installations
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

git_repo_dir=~/git/repos/emacs
hg_repo_dir=~/git/repos/emacs-hg/

repo_dir=$git_repo_dir # choose which repo dir to choose

case $1 in
    git)
        repo_dir=$git_repo_dir
        ;;
    hg)
        repo_dir=$hg_repo_dir
        ;;
    *)
        repo_dir=$git_repo_dir
        ;;
esac

Uname=`whoami`
install_dir=/home/$Uname/local/emacs-git
backup_dir=/home/$Uname/local/emacs-backup

cd $repo_dir
echo "cd to $(pwd)"

Hostname=`hostname`
Make=make
Bootstrap=bootstrap

git_update                      # pull from repo
run_autogen                     # run the autogen to prepare configure script
get_flags                       # look for any flags
run_configure                   # runn the configure script
run_make $1                        # make (make bootstrap)
back_up                         # backup old installation if any and remove old backups
make_install                    # install to the specified directory

# buildemacs.sh ends here
