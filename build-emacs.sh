#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: buildemacs.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Tuesday, March 22 2011
# Licence: GPL v3 or later
#

function announce() {
    echo "
################################
$@
################################
"
}

function exit_with_error() {
    announce "RUNNING:  $1"
    $1 &> $2
    if [[ $? != 0 ]] ; then
        error_convay "while running  $1"
        exit 100;
    fi

}

function error_convay () {
    announce ERROR: $@
}

function run_autogen() {        # run autogen.sh
    announce "running autogen.sh"
    if [ `hostname` == "amur" ]; then
        ./autogen/copy_autogen
    else
        ./autogen.sh &> autogen.log
    fi
}

#--------------------------------------------------------------
# code starts here

#Error returns
repo_dir=~/git/repos/emacs

install_dir=$HOME/local/emacs-git
backup_dir=$HOME/local/emacs-backup

cd $repo_dir

MAKE=make
Bootstrap=bootstrap

if [ ! -f configure ]; then
    run_autogen                     # run the autogen to prepare configure script
fi

git pull

case $Hostname in
    amur )
        conf_flags=' --with-jpeg=no --with-gif=no --with-tiff=no --without-gnutls'
        ;;
    * )
        conf_flags=" --with-gnutls=yes"
        ;;
esac

if [ -d $install_dir ]; then
    if [ -d $backup_dir ]; then
        rm -r $backup_dir
    fi
    mv $install_dir  ${backup_dir}
fi

exit_with_error "make" "make.log"
exit_with_error "make install" "install.log"
[ $? == 0 ] && announce "built emacs successfully"

# buildemacs.sh ends here
