#! /bin/sh
# http://stackoverflow.com/a/8817650/399964

echo ==libtoolize
case `uname` in
    Darwin*) glibtoolize --copy ;;
    *) libtoolize --copy ;;
esac

echo ==autoheader
autoheader

echo ==aclocal -I m4 --install
aclocal -I m4 --install

echo ==autoconf
autoconf

echo ==automake --foreign --add-missing --force-missing --copy
automake --foreign --add-missing --force-missing --copy

# You may need to add ACLOCAL_AMFLAGS = -I m4 to the top-level Makefile.am.
