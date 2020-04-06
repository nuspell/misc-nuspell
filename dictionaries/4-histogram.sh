#!/usr/bin/env sh

# description: create histograms for Hunspell language support
# license: https://github.com/nuspell/nuspell/blob/master/COPYING.LESSER
# author: Sander van Geloven

if [ ! -d utf8 ]; then
	echo 'ERROR: Run the script ./3-convert-and-report.sh first.'
    exit 1
fi

cd utf8

for i in *.txt; do
    filename=`basename $i .txt`
    echo $filename
    ../../tools/histogram.py $i > $filename-historgram.md
done

cd ..
