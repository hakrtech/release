#!/bin/bash
ls -1 x* | sort -u | xargs cat > ./dinesh62b.iso
UNAME=`uname`
if [[ "$UNAME" == "OpenBSD" ]]; then
	md5 -C MD5SUM x* | grep -v OK
else
	md5sum -c MD5SUM | grep -v OK
fi
ls -l *.iso
