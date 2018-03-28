#!/usr/bin/env bash

if [ -e words ]; then
    rm -rf words
fi
mkdir words

# Crude filtering by skipping:
# - first line
# - whitespace
# - slash /
# - comment
# - comma
# - empy line

for path in `find ../1-support/packages -type f -name '*.aff'|sort`; do
#	echo 'path '$path
	package=`echo $path|awk -F '/' '{print $4}'`
#	echo -e '\tpackage '$package
	
	#TODO for testing, limit languages
	if [ $package == 'ar' -o \
	$package == 'be' -o \
	$package == 'br' -o \
	$package == 'es' -o \
	$package == 'eu' -o \
	$package == 'nl' -o \
	$package == 'no' ]; then

	version=`echo $path|awk -F '/' '{print $5}'`
#	echo -e '\tversion '$version
	affix=`echo $path|awk -F '/' '{print $9}'`
#	echo -e '\taffix '$affix
	language=`basename $affix .aff`
	echo -n 'Gathering words for '$language

	mkdir -p words/$language
	tail -n +2 `echo $path|sed -e 's/aff$/dic/'`|grep -av '\s'|grep -av '\/'|grep -av '\#'|grep -av ','|grep -av '^$'>words/$language/dict_$version

	wordlist=`../0-tools/hunspell_language_support_to_wordlist_name.sh $language`
	if [ `echo $wordlist|grep -c ERROR` == 0 ]; then
		wordpackage=`echo $wordlist|awk '{print $2}'`
		wordfile=`echo $wordlist|awk '{print $3}'`
#		echo -e '\t\twordpackage '$wordpackage
#		echo -e '\t\twordfile '$wordfile
		for list in ../2-wordlists/packages/$wordpackage/*/usr/share/dict/$wordfile; do
			wordversion=`echo $list|awk -F '/' '{print $5}'`
			cat $list|grep -av '\s'|grep -av '\/'|grep -av '\#'|grep -av ','|grep -av '^$'>words/$language/list_$wordversion
		done
	fi

	#TODO for testing, limit via "sort -R|head -n 256"
	cat words/$language/*|sort|uniq|sort -R|head -n 256 >words/$language/gathered
	echo ', totaling '`wc -l words/$language/gathered|awk '{print $1}'`

	#TODO for testing, limit languages
	fi
done
