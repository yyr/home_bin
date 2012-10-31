#!/bin/bash

repo_name=${PWD##*/}            # most likely the directory name

function mk_dist()
{
    VERSION=$(git describe --tags)
    git archive --format=tar \
        --output ${repo_name}-$VERSION.tar \
        --prefix="$repo_name/"  $VERSION
    gzip wrf_install-$VERSION.tar
}

if [ -z "$1" ]; then
    mk_dist
else
    home_rev=$(git name-rev --name-only HEAD)
    git checkout "$1"
    mk_dist
    git checkout "$home_rev"
fi
