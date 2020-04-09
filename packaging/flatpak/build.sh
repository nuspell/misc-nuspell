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

# build
flatpak-builder --force-clean build-dir org.nuspell.Nuspell.yaml

# test
flatpak-builder --run build-dir org.nuspell.Nuspell.yaml nuspell -D
