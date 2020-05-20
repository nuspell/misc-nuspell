#!/bin/sh

# description: updates Flathub
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

set -e
cd "$(dirname "$0")"

if [ -e ../../../flathub/org.nuspell.Nuspell.json ]; then
	cp -a org.nuspell.Nuspell.json ../../../flathub/
else
	echo 'INFO: Missing ../../../flathub/org.nuspell.Nuspell.json'
fi

if [ -e ../../../flathub/org.nuspell.Nuspell.metainfo.xml ]; then
	cp -a ../appstream/org.nuspell.Nuspell.metainfo.xml ../../../flathub/
else
	echo 'INFO: Missing ../../../flathub/org.nuspell.Nuspell.metainfo.xml'
fi
if [ -e ../../../flathub/org.nuspell.Nuspell.desktop ]; then
	cp -a ../appstream/org.nuspell.Nuspell.desktop ../../../flathub/
else
	echo 'INFO: Missing ../../../flathub/org.nuspell.Nuspell.desktop'
fi
