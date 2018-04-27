#!/usr/bin/env bash

platform=`../0-tools/platform.sh`
hostname=`hostname`

if [ -e words/$platform ]; then
	rm -rf words/$platform/*
else
	mkdir -p words/$platform
fi

# Crude filtering by skipping:
# 1. first line of dic file with list size
# 2. everything after a slash, but not a slash which is escaped by backslash, that one is unescaped
# 3. comment including and after #

# Crude splitting for:
# 4. whitespace
# 5. comma ,
# 6. hyphen - (only for certain languages)

# Crude filtering by skipping:
# 7. emtpy line

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


if [ $language != el_GR -a $language != af_ZA -a $language != bg_BG -a $language != an_ES -a $language != en_MED -a $language != hr_HR -a $language != kk_KZ -a $language != pt_BR -a $language != th_TH -a $language != pl_PL -a $language != ko -a $language != lt_LT -a $language != es_ES -a $language != nn_NO -a $language != te_IN ]; then

	echo -n 'Gathering words for '$language

	mkdir -p words/$platform/$language
	if [ $language = br_FR -o $language = en_CA -o $language = en_GB -o $language = en_US -o $language = en_ZA -o $language = nn_NO -o $language = nb_NO -o $language = oc_FR -o $language = ro_RO -o $language = sv_SE -o $language = sv_FI -o $language = sk_SK -o $language = sw_TZ -o $language = fo -o $language = se ];then # split on hyphen
		tail -n +2 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'| sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|sed -e 's/-/\n/g'|grep -v [_\&]|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	elif [ $language = gd_GB ];then # split on NON-BREAKING HYPHEN' (U+2011)
		tail -n +2 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'| sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|sed -e 's/‑/\n/g'|grep -v [_\&]|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	elif [ $language = fr ];then # split on hyphen and ndash
		tail -n +2 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|sed -e 's/[–-]/\n/g'|grep -v [_\&]|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	elif [ $language = ar ];then # split on hyphen, extra header
		tail -n +5 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|sed -e 's/-/\n/g'|grep -v [_\&]|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	elif [ $language = de_AT_frami -o $language = de_AT -o $language = de_CH_frami -o $language = de_CH -o $language = de_DE_frami -o $language = de_DE ];then # also license
		tail -n +18 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|grep -v [_\&]|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	elif [ $language = it_IT ];then # also license
		tail -n +35 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|grep -v [_\&]|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	elif [ $package = af ]; then # missing size
		cat ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|grep -v [_\&]|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	else # default
		tail -n +2 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|grep -v [_\&]|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	fi

	word_list=`../0-tools/hunspell_language_support_to_word_list_name.sh $language`
	if [ `echo $word_list|grep -c ERROR` == 0 ]; then
		wordpackage=`echo $word_list|awk '{print $2}'`
		wordfile=`echo $word_list|awk '{print $3}'`
#		echo -e '\t\twordpackage '$wordpackage
#		echo -e '\t\twordfile '$wordfile
		for list in ../2-word-lists/packages/$wordpackage/*/usr/share/dict/$wordfile; do
			wordversion=`echo $list|awk -F '/' '{print $5}'`
			if [ $language = br_FR -o $language = en_CA -o $language = en_GB -o $language = en_US -o $language = en_ZA -o $language = nn_NO -o $language = nb_NO -o $language = oc_FR -o $language = ro_RO -o $language = sv_SE -o $language = sv_FI -o $language = sk_SK -o $language = sw_TZ -o $language = fo ]; then # split on hyphen
				cat ../2-word-lists/utf8/$wordfile.txt|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|sed -e 's/-/\n/g'|grep -v [_\&]|grep -v '^$'|sort|uniq > words/$platform/$language/list_$wordversion
			elif [ $language = fr ]; then # split on hyphen and ndash
				cat ../2-word-lists/utf8/$wordfile.txt|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|sed -e 's/[–-]/\n/g'|grep -v [_\&]|grep -v '^$'|sort|uniq > words/$platform/$language/list_$wordversion
			else
				cat ../2-word-lists/utf8/$wordfile.txt|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|grep -v [_\&]|grep -v '^$'|sort|uniq > words/$platform/$language/list_$wordversion
			fi
		done
	fi

	#TODO for testing, limit via "sort -R|head -n 4096"
#	cat words/$platform/$language/*|sort|uniq|sort -R|head -n 4096 >words/$platform/$language/gathered
	if [ $language = br_FR ]; then # omit period and colon and 
		cat words/$platform/$language/*|grep -v [:.] |sort|uniq >words/$platform/$language/gathered
	elif [ $language = da_DK ]; then # omit numerals (also in subscript and superscript) and apostrophe and hyphen begin of word
		cat words/$platform/$language/*|grep -v "[0-9¹²³₁₂₃']" |grep -v "^-" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = fr ]; then # omit numerals in subscript and superscript and apostrophe and opening and closing braces and hyphen end of word
		cat words/$platform/$language/*|grep -v "[¹²³₁₂₃'()]" |grep -v "\-$" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = ro_RO ]; then # omit numerals
		cat words/$platform/$language/*|grep -v "[0-9]" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = nl_NL ]; then # omit subscript numerals and plus and hyphen begin of word
		cat words/$platform/$language/*|grep -v "[+₁₂₃]" |grep -v "^-" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = sv_SE -o $language = sv_FI ]; then # omit subscript numerals and plus and hyphen begin of word
		cat words/$platform/$language/*|grep -v "[:']" |grep -v "^-" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = en_GB ]; then # omit period and apostrophe and plus
		cat words/$platform/$language/*|grep -v "[+.']" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = en_US ]; then # omit period and apostrophe
		cat words/$platform/$language/*|grep -v "[.']" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = gl_ES -o $language = nb_NO ]; then # omit period
		cat words/$platform/$language/*|grep -v "\." |sort|uniq >words/$platform/$language/gathered
	elif [ $language = sw_TZ ]; then # omit period and apostrophe and numerals
		cat words/$platform/$language/*|grep -v "[0-9.']" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = en_ZA ]; then # omit period and apostrophe and numerals and exclamation mark
		cat words/$platform/$language/*|grep -v "[0-9.']" |grep -v ! |sort|uniq >words/$platform/$language/gathered
	elif [ $language = sr_RS ]; then # omit period and special apostrophe
		cat words/$platform/$language/*|grep -v "[.’]" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = gd_GB ]; then # omit period and ⁊ TIRONIAN SIGN ET and equals
		cat words/$platform/$language/*|grep -v "[1⁊.'=]" | grep -v "!" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = it_IT -o $language = kmr_Latn -o $language = fo -o $language = en_CA -o $language = oc_FR ]; then # omit apostrophe
		cat words/$platform/$language/*|grep -v "'" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = de_CH_frami -o $language = de_AT_frami ]; then # omit apostrophe and plus
		cat words/$platform/$language/*|grep -v "[+']" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = hu_HU ]; then # omit misc
		cat words/$platform/$language/*|grep -v "[@$€}:=§%{|±+'()]" |grep -v "^-"|grep -v "\-$"|sort|uniq >words/$platform/$language/gathered
	elif [ $language = de_DE_frami ]; then # omit apostrophe
# Trög°litz is probably an error
		cat words/$platform/$language/*|grep -v "[+'°]" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = ca -o $language = ca_ES-valencia ]; then # omit numerals (also in subscript and superscript) and apostrophe and plus
		cat words/$platform/$language/*|grep -v "[0-9¹²³₁₂₃+']" |sort|uniq >words/$platform/$language/gathered
#	elif [ $language = te_IN ]; then # omit Uxc02 ం
#		cat words/$platform/$language/*|grep -v "[ ంు]"  |sort|uniq >words/$platform/$language/gathered
	elif [ $language = se ]; then # no start -
		cat words/$platform/$language/*|grep -v "^-"|grep -v "\-$"|sort|uniq >words/$platform/$language/gathered
	else
		cat words/$platform/$language/*|sort|uniq >words/$platform/$language/gathered
	fi
	for file in words/$platform/$language/*; do
		../0-tools/histogram.py $file > words/$platform/$language/`basename $file`-histogram.tsv
	done
	echo ', totaling '`wc -l words/$platform/$language/gathered|awk '{print $1}'`

	#TODO for testing, limit languages
#	fi
fi
done
total_end=`date +%s`
echo $total_end-$total_start | bc > words/$platform/time-$hostname
