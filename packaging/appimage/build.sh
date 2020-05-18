# description: creates AppImage with appimage-builder
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven
set -e
cd "$(dirname "$0")"
appimage-builder --recipe 1804.yml --skip-tests
./Nuspell-3.1.1-x86_64.AppImage -D
