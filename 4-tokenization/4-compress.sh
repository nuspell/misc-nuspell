#!/usr/bin/env sh

# description: compress Wikipedia extracts
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# author: Sander van Geloven

for i in *xml; do
    bzip2 $i
done
