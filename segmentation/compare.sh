#!/usr/bin/env sh

# description: Compare whitespace and Unicode segmentation
# license: https://github.com/nuspell/nuspell/blob/master/COPYING.LESSER
# author: Sander van Geloven

# prerequisits
for PKG in \
	hunspell-en-us \
	hunspell-en-gb \
	hunspell-fr-modern \
	hunspell-de-de-frami \
	hunspell-nl \
	hunspell-ko ;
do
        if [ `dpkg -l $PKG | grep -c ^ii` -eq 0 ]; then
                echo 'Missing package '$PKG
                exit 1
        fi
done

# compare
for i in *.txt; do
	LANG=$(basename $i .txt)
	echo $LANG
	nuspell -d $LANG $i > $LANG.whitespace 2>&1
	nuspell -S -d $LANG $i > $LANG.unicode 2>&1
done
