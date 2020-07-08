#!/bin/sh

# description: creates AppImage with appimage-builder
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

set -e
cd "$(dirname "$0")"

appimage-builder --skip-tests #--recipe AppImageBuilder.yml
./Nuspell-3.1.2-x86_64.AppImage -D
