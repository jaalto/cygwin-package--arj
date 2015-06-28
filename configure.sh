#!/bin/sh
# Copyright (C) 2009 Jari Aalto; Licensed under GPL v2 or later
#
# configure.sh -- Custom configure script
#
#   Called as: CYGWIN-PATCHES/configure.sh <absolute-install-dir>

PATH="/sbin:/usr/sbin/:/bin:/usr/bin"
LC_ALL="C"

Configure()
{
    instdir="$1"
    instdir=${instdir%/}  # Remove trailing slash

    if  [ -z  "$instdir" ] || [ ! -d $instdir ]; then
        echo "$0: [ERROR] No such dir [$instdir]" >&2
        exit 1
    else
        #   EXAMPLE: Any custom configuration options

        pwd
	cd gnu || return $?

        cp ../CYGWIN-PATCHES/config.* . || exit $?

        if [ ! -f ./configure ]; then
            echo ">> Wait, generating ./configure with autoconf -f -i"
            autoconf -f -i
        fi

        ./configure                       \
        --prefix=/usr                     \
        --sysconfdir=/etc                 \
        --libexecdir='${sbindir}'         \
        --exec-prefix=/usr                \
        --localstatedir=/var              \
        --datadir='${prefix}/share'       \
        --mandir='${prefix}/share/man'    \
        --infodir='${prefix}/share/info'  \
        --libdir='${prefix}/lib'          \
        --includedir='${prefix}/include'

    fi
}

Configure "$@"

# End of file
