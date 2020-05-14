#!/bin/sh

# description: creates Flatpak
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

set -e
cd "$(dirname "$0")"

# prerequisits
if [ -z $(which flatpak-builder) ]; then
	echo 'Missing executable flatpak-builder'
	exit 1
fi
desktop-file-validate org.nuspell.Nuspell.desktop

# clean
if [ -e .flatpak-builder ]; then
	rm -rf .flatpak-builder
fi

# validate
appstreamcli validate ../appstream/org.nuspell.Nuspell.metainfo.xml

# build
flatpak-builder --force-clean build-dir org.nuspell.Nuspell.json

# test
flatpak-builder --run build-dir org.nuspell.Nuspell.json nuspell -D
