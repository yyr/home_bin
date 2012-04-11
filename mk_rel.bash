#!/bin/bash
# make release from a git repo
# either by tag or rev or HEAD,
# (takes folder name as directory)

if [ ! -d .git ] ; then
    echo "This should be called in the git repository"
    exit
fi

repo_name=${PWD##*/}

function mk_dist()
{
    VERSION=$(git describe --tags)
    git archive --format=tar \
        --output $repo_name-$VERSION.tar \
        --prefix="$repo_name/"  $VERSION
    gzip $repo_name-$VERSION.tar
}

if [ -z "$1" ]; then
    mk_dist
else
    home_rev=$(git name-rev --name-only HEAD)
    git checkout "$1"
    mk_dist
    git checkout "$home_rev"
fi
