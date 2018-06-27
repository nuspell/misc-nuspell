#!/usr/bin/env sh

# author: Sander van Geloven
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# description: combines articles from Wikipedia exports

rm -f combined-*.txt

for i in *-latest-pages-articles-multistream/*/*; do
	lang=`echo $i|awk -F 'wik' '{print $1}'`
	# filter out errors from WikiExtractor and filter out number elements
	cat $i|grep -Ev '</?[A-Za-z]{4,}.*>'|grep -Ev '</?div.*>'|grep -Ev '</?del.*>'|grep -Ev '</?ref.*>'|grep -Ev '</?xsd.*>'|grep -Ev '</?[0-9]+>' >> combined-$lang.txt
done
