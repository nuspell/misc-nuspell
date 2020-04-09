#!/bin/sh

# description: creates Flatpak
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

set -e
cd "$(dirname "$0")"

# prerequisits
#TODO if [ -z which flatpak-builder ]; then
#	echo ERROR

# build
flatpak-builder build-dir org.nuspell.Nuspell.yaml

# test
flatpak-builder --run build-dir org.nuspell.Nuspell.yaml nuspell -D
