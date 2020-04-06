#!/usr/bin/env sh

# description: Extracts downloaded dictionary packages
# license: https://github.com/nuspell/nuspell/blob/master/COPYING.LESSER
# author: Sander van Geloven

if [ ! -d packages ]; then
	echo 'ERROR: First, run the script ./1-download.sh'
	exit 1
fi
if [ -e files ]; then
	rm -rf files/*
else
	mkdir files
fi

cd files

# Packages tp be skipped:
# - Myspell packages with identical aff and identical dic files in related
#   Hunspell package
# - Empty dummy transitional packages
# - Additional medical dictionaries
SKIP='myspell-he
myspell-nb
myspell-nn
myspell-el-gr
myspell-pt
hunspell-fr
hunspell-de-med
hunspell-en-med'

for i in $(ls ../packages/*.deb|sort); do
	TMP=$(basename $i)
	PACKAGE=$(echo $TMP|awk -F _ '{print $1}')
	if [ $(echo $SKIP|grep -c $PACKAGE) -ne 0 ]; then
		echo 'Skipping '$i
		continue
	fi
	echo 'Extracting '$i
	mkdir $TMP
	dpkg -x $i $TMP
	DIRECTORY=$(echo $TMP|awk -F _ '{print $1"_"$2}')
	mkdir $DIRECTORY
	find $TMP -name '*.aff' -type f -exec cp {} $DIRECTORY \;
	find $TMP -name '*.dic' -type f -exec cp {} $DIRECTORY \;
	rm -rf $TMP
done
find ./ -name 'hyph*.dic' -exec rm -f  {} \;

echo 'Consider the output below for extra packages to skip'
echo 'Empty directories:'
find ./ -type d -empty
echo 'Duplicate files:'
fdupes -r .

cd ..
