#!/usr/bin/env bash

platform=`../0-tools/platform.sh`
hostname=`hostname`

if [ -e words/$platform ]; then
	rm -rf words/$platform/*
else
	mkdir -p words/$platform
fi

# Crude filtering by skipping:
# - first line
# - whitespace
# - slash /
# - comment #
# - comma ,
# - emtpy line

# Crude splitting for:
# - space
# - hyphen - (only for certain languages)

total_start=`date +%s`
for path in `find ../1-support/packages -type f -name '*.aff'|sort`; do
#	echo 'path '$path
	package=`echo $path|awk -F '/' '{print $4}'`
#	echo -e '\tpackage '$package
	
	#TODO for testing, limit languages
	if [ $package == 'ar' -o \
	$package == 'be' -o \
	$package == 'br' -o \
	$package == 'sk' -o \
	$package == 'en-gb' -o \
	$package == 'uk' -o \
	$package == 'uz' -o \
	$package == 'vi' -o \
	$package == 'nl' ]; then

	version=`echo $path|awk -F '/' '{print $5}'`
#	echo -e '\tversion '$version
	affix=`echo $path|awk -F '/' '{print $9}'`
#	echo -e '\taffix '$affix
	language=`basename $affix .aff`
	echo -n 'Gathering words for '$language

	mkdir -p words/$platform/$language
	if [ $language = 'en_GB' ];then
		tail -n +2 `echo $path|sed -e 's/aff$/dic/'`|grep -av '\s'|grep -av '\/'|grep -av '\#'|sed -e 's/ /\n/g'|sed -e 's/,/\n/g'|sed -e 's/-/\n/g'|grep -av '^$'|sort|uniq > words/$platform/$language/dict_$version
	else
		tail -n +2 `echo $path|sed -e 's/aff$/dic/'`|grep -av '\s'|grep -av '\/'|grep -av '\#'|sed -e 's/ /\n/g'|sed -e 's/,/\n/g'|grep -av '^$'|sort|uniq > words/$platform/$language/dict_$version
	fi

	wordlist=`../0-tools/hunspell_language_support_to_wordlist_name.sh $language`
	if [ `echo $wordlist|grep -c ERROR` == 0 ]; then
		wordpackage=`echo $wordlist|awk '{print $2}'`
		wordfile=`echo $wordlist|awk '{print $3}'`
#		echo -e '\t\twordpackage '$wordpackage
#		echo -e '\t\twordfile '$wordfile
		for list in ../2-wordlists/packages/$wordpackage/*/usr/share/dict/$wordfile; do
			wordversion=`echo $list|awk -F '/' '{print $5}'`
			if [ $language = 'en_GB' ];then
				cat $list|grep -av '\s'|grep -av '\/'|grep -av '\#'|sed -e 's/ /\n/g'|sed -e 's/,/\n/g'|sed -e 's/-/\n/g'|grep -av '^$'|sort|uniq > words/$platform/$language/list_$wordversion
			else
				cat $list|grep -av '\s'|grep -av '\/'|grep -av '\#'|sed -e 's/ /\n/g'|sed -e 's/,/\n/g'|grep -av '^$'|sort|uniq > words/$platform/$language/list_$wordversion
			fi
		done
	fi

	#TODO for testing, limit via "sort -R|head -n 4096"
	cat words/$platform/$language/*|sort|uniq|sort -R|head -n 4096 >words/$platform/$language/gathered
	echo ', totaling '`wc -l words/$platform/$language/gathered|awk '{print $1}'`

	#TODO for testing, limit languages
	fi
done
total_end=`date +%s`
echo $total_end-$total_start | bc > words/$platform/time-$hostname
