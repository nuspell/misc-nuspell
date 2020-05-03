#!/bin/sh

# description: creates Snap
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

set -e
cd "$(dirname "$0")"

# prerequisits
if [ -z $(which snapcraft) ]; then
        echo 'Missing executable snapcraft'
        exit 1
fi

# build
cd ../..
snapcraft
