#!/usr/bin/env sh

# description: Extracts downloaded dictionary packages
# license: https://github.com/nuspell/nuspell/blob/master/COPYING.LESSER
# author: Sander van Geloven

set -e
cd $(dirname "$0")
if [ ! -d downloads ]; then
	echo 'ERROR: First, run the script ./1-download.sh'
	exit 1
fi
if [ -e extractions ]; then
	rm -rf extractions/*
else
	mkdir extractions
fi
cd extractions

# Skip Myspell packages with identical files in related Hunspell package
SKIP_IDENTICAL='myspell-he
myspell-nb
myspell-nn
myspell-el-gr'
# Skip meta packages or dummy transitional packages that are empty
SKIP_EMPTY='myspell-pt
hunspell-fr'
# Skip additional dictionaries without affix file
SKIP_ADDITIONAL='hunspell-de-med
hunspell-en-med'
# Skip dictionaries with file format errors
SKIP_FORMAT='myspell-hu
hunspell-hu'

for i in $(ls ../downloads/*.deb|sort); do
	TMP=$(basename $i)
	PACKAGE=$(echo $TMP|awk -F _ '{print $1}')
	if [ $(echo $SKIP_IDENTICAL|grep -c $PACKAGE) -ne 0 ]; then
		echo 'Skipping identical package '$i
		continue
	fi
	if [ $(echo $SKIP_EMPTY|grep -c $PACKAGE) -ne 0 ]; then
		echo 'Skipping empty package '$i
		continue
	fi
	if [ $(echo $SKIP_ADDITIONAL|grep -c $PACKAGE) -ne 0 ]; then
		echo 'Skipping additional package '$i
		continue
	fi
	if [ $(echo $SKIP_FORMAT|grep -c $PACKAGE) -ne 0 ]; then
		echo 'Skipping package '$i
		continue
	fi
	echo 'Extracting '$i
	mkdir $TMP
	dpkg -x $i $TMP
	DIRECTORY=$(echo $TMP|awk -F _ '{print $1"_"$2}')
	mkdir $DIRECTORY
	find $TMP/usr/share/ -name '*.aff' -type f -exec cp {} $DIRECTORY \;
	find $TMP/usr/share/ -name '*.dic' -type f -exec cp {} $DIRECTORY \;
	rm -rf $TMP
done
find ./ -name 'hyph*.dic' -exec rm -f  {} \;

# Temporary fix for https://github.com/nuspell/nuspell/issues/30
find ./ -name lv_LV.aff -exec sed -e 's/|^cz]īt/[^cz]īt/' -i {} \;

# Temporary fix for incorrect ISO-8859-? file type
echo "SET UTF-8\nTRY aeoltinghmškswrpbdufyMcSjTBDLNPKRAvCEz-GIHOFWJV'xUYZqXŠQéÉè" > tmp
find ./ -name ve_ZA.aff -exec cp -f tmp {} \;
rm -f tmp

echo 'Consider the output below for extra packages to skip'
echo 'Empty directories:'
find ./ -type d -empty
echo 'Duplicate files:'
fdupes -r .

cd ..
