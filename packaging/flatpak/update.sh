#!/bin/sh

# description: updates Flathub
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

set -e
cd "$(dirname "$0")"

if [ -d ../../../flathub/ ]; then
	cp -a org.nuspell.Nuspell.json ../../../flathub/
	cp -a ../appstream/org.nuspell.Nuspell.metainfo.xml ../../../flathub/
else
	echo 'INFO: Missing directory ../../../flathub/'
fi
