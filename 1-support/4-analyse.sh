#!/usr/bin/env sh

# description: analyses Hunspell language support
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# author: Sander van Geloven

if [ ! -d utf8 ]; then
	echo 'ERROR: Run the script ./3-convert-and-report.sh first.'
    exit 1
fi

cd utf8

for i in *.txt; do
    filename=`basename $i .dic`
    echo $filename
    ../../0-tools/histogram.py $i > $filename-historgram.md
done

cd ..
