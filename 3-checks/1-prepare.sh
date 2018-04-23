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
# - backslash \
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
#	if [ $package == 'ar' -o \
#	$package == 'be' -o \
#	$package == 'bo' -o \
#	$package == 'br' -o \
#	$package == 'en-gb' -o \
#	$package == 'kmr' -o \
#	$package == 'ne' -o \
#	$package == 'nl' -o \
#	$package == 'pl' -o \
#	$package == 'sk' -o \
#	$package == 'uk' -o \
#	$package == 'uz' -o \
#	$package == 'vi' ]; then

	version=`echo $path|awk -F '/' '{print $5}'`
#	echo -e '\tversion '$version
	affix=`echo $path|awk -F '/' '{print $9}'`
#	echo -e '\taffix '$affix
	language=`basename $affix .aff`


if [ $language != af_ZA -a $language != bg_BG -a $language != an_ES -a $language != en_MED -a $language != hr_HR -a $language != kk_KZ -a "$language" != pt_BR -a "$language" != th_TH -a "$language" != pl_PL ]; then

	echo -n 'Gathering words for '$language

	mkdir -p words/$platform/$language
	if [ $language = 'en_GB' ];then
		tail -n +2 ../1-support/utf8/$language.txt|grep -v '\s'|grep -v '\\'|grep -v '\/'|grep -v '\#'|sed -e 's/ /\n/g'|sed -e 's/,/\n/g'|sed -e 's/-/\n/g'|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	elif [ $language = 'de_AT_frami' -o $language = 'de_AT' -o $language = 'de_CH_frami' -o $language = 'de_CH' -o $language = 'de_DE_frami' -o $language = 'de_DE' ];then
		tail -n +18 ../1-support/utf8/$language.txt|grep -v '\s'|grep -v '\\'|grep -v '\/'|grep -v '\#'|sed -e 's/ /\n/g'|sed -e 's/,/\n/g'|sed -e 's/-/\n/g'|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	elif [ $package = 'af' ]; then
		cat ../1-support/utf8/$language.txt|grep -v '\s'|grep -v '\\'|grep -v '\/'|grep -v '\#'|sed -e 's/ /\n/g'|sed -e 's/,/\n/g'|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	else
		tail -n +2 ../1-support/utf8/$language.txt|grep -v '\s'|grep -v '\\'|grep -v '\/'|grep -v '\#'|sed -e 's/ /\n/g'|sed -e 's/,/\n/g'|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	fi

	word_list=`../0-tools/hunspell_language_support_to_word_list_name.sh $language`
	if [ `echo $word_list|grep -c ERROR` == 0 ]; then
		wordpackage=`echo $word_list|awk '{print $2}'`
		wordfile=`echo $word_list|awk '{print $3}'`
#		echo -e '\t\twordpackage '$wordpackage
#		echo -e '\t\twordfile '$wordfile
		for list in ../2-word-lists/packages/$wordpackage/*/usr/share/dict/$wordfile; do
			wordversion=`echo $list|awk -F '/' '{print $5}'`
			if [ $language = 'en_GB' ]; then
				cat ../2-word-lists/utf8/$wordfile.txt|grep -v '\s'|grep -v '\\'|grep -v '\/'|grep -v '\#'|sed -e 's/ /\n/g'|sed -e 's/,/\n/g'|sed -e 's/-/\n/g'|grep -v '^$'|sort|uniq > words/$platform/$language/list_$wordversion
			else
				cat ../2-word-lists/utf8/$wordfile.txt|grep -v '\s'|grep -v '\\'|grep -v '\/'|grep -v '\#'|sed -e 's/ /\n/g'|sed -e 's/,/\n/g'|grep -v '^$'|sort|uniq > words/$platform/$language/list_$wordversion
			fi
		done
	fi

	#TODO for testing, limit via "sort -R|head -n 4096"
#	cat words/$platform/$language/*|sort|uniq|sort -R|head -n 4096 >words/$platform/$language/gathered
	cat words/$platform/$language/*|sort|uniq >words/$platform/$language/gathered
	../0-tools/histogram.py words/$platform/$language/gathered > words/$platform/$language/gathered-histogram.tsv
	echo ', totaling '`wc -l words/$platform/$language/gathered|awk '{print $1}'`

	#TODO for testing, limit languages
#	fi
fi
done
total_end=`date +%s`
echo $total_end-$total_start | bc > words/$platform/time-$hostname
