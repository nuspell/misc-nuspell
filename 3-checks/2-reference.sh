#!/usr/bin/env sh


# Initialization

platform=`../0-tools/platform.sh`
hostname=`hostname`
machine=$platform\_$hostname

if [ ! -d words ]; then
	echo 'ERROR: Run the script ./1-prepare.sh first.'
    exit 1
fi

if [ -e regression/$machine ]; then
	rm -rf regression/$machine/*
else
	mkdir -p regression/$machine
fi


# Building Nuspell for certain commit, default is latest commit

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
	./configure CXXFLAGS='-O2 -fno-omit-frame-pointer'
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to configure nuspell/hunspell'
		exit 1
	fi
	make -j CXXFLAGS='-O2 -fno-omit-frame-pointer'
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to build nuspell/hunspell'
		exit 1
	fi
fi
cd ..


# Starting regression test for all supported languages

#total_start=`date +%s`

for path in `find ../1-support/files -type f -name '*.aff'|sort`; do
	package=`echo $path|awk -F '/' '{print $4}'`
	dictionary=`echo $path|sed -e 's/\.aff//'`
	version=`echo $path|awk -F '/' '{print $5}'`
	affix=`echo $path|awk -F '/' '{print $9}'`
	language=`basename $affix .aff`


	# Starting regression test for specific language

	if [ -e words/$language/gathered ]; then # errors that need fixing, na HU is voor speedup

#] && [ $language != bg_BG -a $language != ar -a $language != bn_BD -a $language != sl_SI -a $language != cs_CZ -a $language != bs_BA -a $language != fa_IR -a $language != sr_Latn_RS -a $language != ru_RU -a $language != pt_PT -a $language != eu -a $language != ml_IN -a $language != si_LK -a $language != ne_NP -a $language != gu_IN -a $language != hi_IN -a $language != hu_HU -a $language != ca -a $language != nl

		wordsin=`cat words/$language/gathered.total`
		echo -n 'Running Hunspell for '$language' on '$wordsin' gathered words'
		mkdir -p regression/$machine/$language
#		start=`date +%s`
#		echo nuspell/src/nuspell/regress -i UTF-8 -d $dictionary words/$language/gathered
		nuspell/src/nuspell/regress -i UTF-8 -d $dictionary words/$language/gathered 2> regression/$machine/$language/stderr > regression/$machine/$language/result
#		end=`date +%s`
#		echo $end-$start|bc > regression/$machine/$language/time

		# get list of output words
#		awk -F '\t' '{print $2}' regression/$machine/$language/gathered.full > regression/$machine/$language/gathered
#		# get list of spelling result
#		awk -F '\t' '{print $1}' regression/$machine/$language/gathered.full > regression/$machine/$language/gathered.spelling
#		# calculate total
#		total_in=wc -l regression/$machine/$language/gathered.spelling|awk '{print $1}'>regression/$machine/$language/gathered.total
		wordsout=`tail -n 1 regression/$machine/$language/result | awk '{print $1}'`
#
#		# compare list of input words with list of output words
#		if [ -z `diff -q words/$language/gathered regression/$machine/$language/gathered|awk '{print $1}'` ]; then
		if [ $wordsin -eq $wordsout ]; then
			echo
#			# recombine list of output words and list of spelling result
#			paste -d"\t" regression/$machine/$language/gathered.spelling words/$language/gathered > regression/$machine/$language/gathered.tsv
#
#			# filter and calculate totals
#
#			# correct
#			grep '^[*+-]' regression/$machine/$language/gathered.tsv|awk -F '\t' '{print $2}'>regression/$machine/$language/gathered.correct
#			wc -l regression/$machine/$language/gathered.correct|awk '{print $1}'>regression/$machine/$language/gathered.total_correct
#			# incorrect
#			grep '^[#&]' regression/$machine/$language/gathered.tsv|awk -F '\t' '{print $2}'>regression/$machine/$language/gathered.incorrect
#			wc -l regression/$machine/$language/gathered.incorrect|awk '{print $1}'>regression/$machine/$language/gathered.total_incorrect
#			# okay
#			grep '^*' regression/$machine/$language/gathered.tsv|awk -F '\t' '{print $2}'>regression/$machine/$language/gathered.okay
#			wc -l regression/$machine/$language/gathered.okay|awk '{print $1}'>regression/$machine/$language/gathered.total_okay
#			# affixed
#			grep '^+' regression/$machine/$language/gathered.tsv|awk -F '\t' '{print $2}'>regression/$machine/$language/gathered.affixed
#			wc -l regression/$machine/$language/gathered.affixed|awk '{print $1}'>regression/$machine/$language/gathered.total_affixed
#			# compounded
#			grep '^-' regression/$machine/$language/gathered.tsv|awk -F '\t' '{print $2}'>regression/$machine/$language/gathered.compounded
#			wc -l regression/$machine/$language/gathered.compounded|awk '{print $1}'>regression/$machine/$language/gathered.total_compounded
#			# near miss
#			grep '^&' regression/$machine/$language/gathered.tsv|awk -F '\t' '{print $2}'>regression/$machine/$language/gathered.nearmiss
#			wc -l regression/$machine/$language/gathered.nearmiss|awk '{print $1}'>regression/$machine/$language/gathered.total_nearmiss
#			#unknown
#			grep '^#' regression/$machine/$language/gathered.tsv|awk -F '\t' '{print $2}'>regression/$machine/$language/gathered.unknown
#			wc -l regression/$machine/$language/gathered.unknown|awk '{print $1}'>regression/$machine/$language/gathered.total_unknown
#
#			echo -n ', scoring '
#			echo `cat regression/$machine/$language/gathered.total_correct`'/'`cat words/$language/gathered.total`'*100'|bc -l|sed -e 's/\(\....\).*$/\1%/'
		else
			echo
			echo 'ERROR: Number of words in ('$wordsin') and number of results out ('$wordsout') do not match for '$language
		fi

	fi # errors that need fixing
done


# Logging total time needed

#total_end=`date +%s`
#echo $total_end-$total_start|bc > regression/$machine/time
