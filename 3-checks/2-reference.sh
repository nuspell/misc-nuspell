#!/usr/bin/env bash

platform=`../0-tools/platform.sh`
hostname=`hostname`

if [ -e reference/$platform ]; then
	rm -rf reference/$platform/*
else
	mkdir -p reference/$platform
fi

updated=0
if [ -e nuspell ]; then
	cd nuspell
	updated=`git pull -r|grep -c 'Already up to date.'`
else
	git clone https://github.com/hunspell/nuspell.git
	cd nuspell
fi

commit=`git log|head -n 1|awk '{print $2}'`

if [ $updated -eq 0 ]; then
	autoreconf -vfi
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to automatically reconfigure nuspell/hunspell'
		exit 1
	fi
	./configure
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to configure nuspell/hunspell'
		exit 1
	fi
	make -j
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to build nuspell/hunspell'
		exit 1
	fi
	make check
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to test nuspell/hunspell'
		exit 1
	fi
fi
cd ..

total_start=`date +%s`

for path in `find ../1-support/packages -type f -name '*.aff'|sort`; do
	package=`echo $path|awk -F '/' '{print $4}'`
	version=`echo $path|awk -F '/' '{print $5}'`
	affix=`echo $path|awk -F '/' '{print $9}'`
	language=`basename $affix .aff`

	if [ -e words/$platform/$language/gathered ] && [ $language != bg_BG -a $language != ar -a $language != bn_BD -a $language != sl_SI -a $language != cs_CZ -a $language != bs_BA -a $language != fa_IR -a $language != sr_Latn_RS -a $language != ru_RU -a $language != pt_PT -a $language != eu -a $language != ml_IN -a $language != si_LK -a $language != ne_NP -a $language != gu_IN -a $language != hi_IN -a $language != hu_HU ]; then # errors that need fixing

		echo -n 'Running Hunspell for '$language' on '`cat words/$platform/$language/gathered.total`' gathered words'
		mkdir -p reference/$platform/$language
		start=`date +%s`
		nuspell/src/tools/hunspell -Y -i UTF-8 -d `echo $path|sed -e 's/\.aff//'` -a words/$platform/$language/gathered 2> reference/$platform/$language/stderr | grep -v 'International Ispell Version'|grep -v '^$' > reference/$platform/$language/gathered.full
		end=`date +%s`
		echo $end-$start|bc > reference/$platform/$language/time-$hostname

		# get list of output words
		awk '{print $2}' reference/$platform/$language/gathered.full > reference/$platform/$language/gathered
		# get list of spelling result
		awk '{print $1}' reference/$platform/$language/gathered.full > reference/$platform/$language/gathered.spelling
		# calculate total
		wc -l reference/$platform/$language/gathered.spelling|awk '{print $1}'>reference/$platform/$language/gathered.total

		# compare list of input words with list of output words
		if [ -z `diff -q words/$platform/$language/gathered reference/$platform/$language/gathered|awk '{print $1}'` ]; then
			# recombine list of output words and list of spelling result
			paste -d"\t" reference/$platform/$language/gathered.spelling words/$platform/$language/gathered > reference/$platform/$language/gathered.tsv

			# filter and calculate totals

			# correct
			grep '^[*+-]' reference/$platform/$language/gathered.tsv|awk '{print $2}'>reference/$platform/$language/gathered.correct
			wc -l reference/$platform/$language/gathered.correct|awk '{print $1}'>reference/$platform/$language/gathered.total_correct
			# incorrect
			grep '^[#&]' reference/$platform/$language/gathered.tsv|awk '{print $2}'>reference/$platform/$language/gathered.incorrect
			wc -l reference/$platform/$language/gathered.incorrect|awk '{print $1}'>reference/$platform/$language/gathered.total_incorrect
			# okay
			grep '^*' reference/$platform/$language/gathered.tsv|awk '{print $2}'>reference/$platform/$language/gathered.okay
			wc -l reference/$platform/$language/gathered.okay|awk '{print $1}'>reference/$platform/$language/gathered.total_okay
			# affixed
			grep '^+' reference/$platform/$language/gathered.tsv|awk '{print $2}'>reference/$platform/$language/gathered.affixed
			wc -l reference/$platform/$language/gathered.affixed|awk '{print $1}'>reference/$platform/$language/gathered.total_affixed
			# compounded
			grep '^-' reference/$platform/$language/gathered.tsv|awk '{print $2}'>reference/$platform/$language/gathered.compounded
			wc -l reference/$platform/$language/gathered.compounded|awk '{print $1}'>reference/$platform/$language/gathered.total_compounded
			# near miss
			grep '^&' reference/$platform/$language/gathered.tsv|awk '{print $2}'>reference/$platform/$language/gathered.nearmiss
			wc -l reference/$platform/$language/gathered.nearmiss|awk '{print $1}'>reference/$platform/$language/gathered.total_nearmiss
			#unknown
			grep '^#' reference/$platform/$language/gathered.tsv|awk '{print $2}'>reference/$platform/$language/gathered.unknown
			wc -l reference/$platform/$language/gathered.unknown|awk '{print $1}'>reference/$platform/$language/gathered.total_unknown

			echo -n ', scoring '
			echo `cat reference/$platform/$language/gathered.total_correct`'/'`cat words/$platform/$language/gathered.total`'*100'|bc -l|sed -e 's/\(\....\).*$/\1%/'
		else
			echo
			echo 'ERROR: Number of words in ('`cat words/$platform/$language/gathered.total`') and number of results out ('`cat reference/$platform/$language/gathered.total|awk '{print $1}'`') do not match for '$language
		fi

	fi # errors that need fixing
done

total_end=`date +%s`
echo $total_end-$total_start|bc > reference/$platform/time-$hostname
