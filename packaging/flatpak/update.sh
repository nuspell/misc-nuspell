#!/bin/sh

# description: updates Flathub
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

set -e
cd "$(dirname "$0")"

if [ -d ../../../org.nuspell.Nuspell/ ]; then
	cp -a org.nuspell.Nuspell.json ../../../org.nuspell.Nuspell/
	cp -a ../appstream/org.nuspell.Nuspell.metainfo.xml ../../../org.nuspell.Nuspell/
else
	echo 'INFO: Missing directory ../../../org.nuspell.Nuspell/'
fi
