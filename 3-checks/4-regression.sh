#!/usr/bin/env bash

if [ ! -e regression ]; then
	mkdir regression
fi

if [ -e nuspell ]; then
	cd nuspell
	git pull
else
	git clone https://github.com/hunspell/nuspell.git
	cd nuspell
fi
commit=`git log|head -n 1|awk '{print $2}'`
autoreconf -vfi
if [ $? -ne 0 ]; then
	echo 'ERROR: Failed to automatically reconfigure nuspell'
	exit
fi
./configure
if [ $? -ne 0 ]; then
	echo 'ERROR: Failed to configure nuspell'
	exit
fi
make
if [ $? -ne 0 ]; then
	echo 'ERROR: Failed to build nuspell'
	exit
fi
make check
if [ $? -ne 0 ]; then
	echo 'ERROR: Failed to test nuspell'
	exit
fi
cd ..

echo $commit
mkdir regression/$commit

for path in `find ../1-support/packages -type f -name '*.aff'|sort`; do
	package=`echo $path|awk -F '/' '{print $4}'`
	version=`echo $path|awk -F '/' '{print $5}'`
	affix=`echo $path|awk -F '/' '{print $9}'`
	language=`basename $affix .aff`

	if [ -e words/$language/unified ]; then
		echo $language
		mkdir -p regression/$commit/$language
	fi
done

exit

for path in `find ../1-support/packages -type f -name '*.aff'|sort`; do
	package=`echo $path|awk -F '/' '{print $4}'`
	version=`echo $path|awk -F '/' '{print $5}'`
	affix=`echo $path|awk -F '/' '{print $9}'`
	language=`basename $affix .aff`

	if [	$language == 'se' -o \
		$language == 'lo_LA' -o \
		$language == 'he_IL' -o \
		$language == 'bo' -o \
		$language == 'dz' -o \
		$language == 'kmr_Latn' -o \
		$language == 'sv_FI' -o \
		$language == 'vi_VN' ]; then
		for file in words/$language/unified; do
			mkdir -p regression/$language
			echo $file `echo $path|sed -e 's/\.aff//'`
#exit
			../../nuspell/src/nuspell/nuspell -d `echo $path|sed -e 's/\.aff//'` $file > regression/$language/unified
			grep '^&' regression/$language/unified|wc -l>regression/$language/unified.bad
			grep '^*' regression/$language/unified|wc -l>regression/$language/unified.good
		done
	fi

done
#		$language == 'an_ES' -o \

#		$language == 'ru_RU' -o \
#		$language == 'cs_CZ' -o \

#		$language == 'hu_HU' -o \
#		$language == 'oc_FR' -o \

#		$language == 'lt_LT' -o \
#		$language == 'bs_BA' -o \
#		$language == 'de_AT' -o \
#		$language == 'bg_BG' -o \

