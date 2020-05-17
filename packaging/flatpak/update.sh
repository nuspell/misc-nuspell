#!/bin/sh

# description: updates Flathub
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

set -e
cd "$(dirname "$0")"

if [ -e ../../../flathub/org.nuspell.Nuspell.json ]; then
	cp -a org.nuspell.Nuspell.json ../../../flathub/org.nuspell.Nuspell.json
else
	echo 'Missing ../../../flathub/org.nuspell.Nuspell.json'
	exit 1
fi

if [ -e ../../../flathub/org.nuspell.Nuspell.metainfo.xml ]; then
	cp -a ../appstream/org.nuspell.Nuspell.metainfo.xml ../../../flathub/org.nuspell.Nuspell.metainfo.xml
else
	echo 'Missing ../../../flathub/org.nuspell.Nuspell.metainfo.xml'
	exit 1
fi
