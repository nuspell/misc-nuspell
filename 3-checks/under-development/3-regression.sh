#!/usr/bin/env sh

# description: regression test specific git commit for function and speed
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# author: Sander van Geloven

if [ $# -ge 2 ]; then
	echo 'ERROR: Only one optional parameter indicating specific commit is allowed'
	exit 1
fi

platform=`../0-tools/platform.sh`
hostname=`hostname`

if [ ! -d reference/$platform ]; then
	echo 'ERROR: Run the script ./2-reference.sh first.'
    exit 1
fi

updated=0
if [ -e nuspell ]; then
	cd nuspell
	updated=`git pull -r|grep -c 'Already up to date.'`
else
	git clone https://github.com/hunspell/nuspell.git
	cd nuspell
fi

if [ $# -eq 0 ]; then
	commit=`git log|head -n 1|awk '{print $2}'`
	timestamp=`git log --date=raw|head -n 3|tail -n 1|awk '{print $2}'`
else
	commit=$1
	timestamp=`git log $commit --date=raw|head -n 3|tail -n 1|awk '{print $2}'`
fi
handle=`echo $commit|sed -e 's/^\(.......\).*/\1/'`

if [ ! -e regression/$platform ]; then
	rm -rf TODOregression/$platform/$commit\_$timestamp
else
	mkdir -p regression/$platform
fi

if [ $updated -eq 0 ]; then
	autoreconf -vfi
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to automatically reconfigure nuspell/nuspell'
		exit 1
	fi
	./configure CXXFLAGS='-O2 -fno-omit-frame-pointer'
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to configure nuspell/nuspell'
		exit 1
	fi
	make clean
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to build nuspell/nuspell'
		exit 1
	fi
	make -j CXXFLAGS='-O2 -fno-omit-frame-pointer'
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to build nuspell/nuspell'
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

	if [ -e words/$platform/$language/gathered ]; then

	if [ $language != eu -a $language != ca -a $language != ca_ES-valencia ]; then # to speed up development of this script

	if [ $language != lv_LV -a $language != gl_ES -a $language != hu_HU -a $language != it_IT -a $language != kmr_Latn -a $language != nb_NO -a $language != oc_FR -a $language != sk_SK -a $language != sr_Latn_RS -a $language != sv_FI -a $language != sv_SE ]; then # warnings or errors in stderr

		run_test=1
#		if [ -e regression/$platform/$language/time-$hostname.tsv ]; then
#			if [ "`grep -c $commit regression/$platform/$language/time-$hostname.tsv`" = 1 ]; then
#				reun_test=0
#			fi
#		fi
#		if [ -e regression/$platform/$language/correctness.tsv ]; then
#			if [ "`grep -c $commit regression/$platform/$language/correctness.tsv`" = 1 ]; then
#				reun_test=0
#			fi
#		fi
		if [ $run_test -eq 1 ]; then
			echo -n 'Running Nuspell '$handle' for '$language' on '`wc -l words/$platform/$language/gathered|awk '{print $1}'`' gathered words'
			mkdir -p regression/$platform/$commit\_$timestamp/$language
			start=`date +%s`
			nuspell/src/nuspell/nuspell -i UTF-8 -d `echo $path|sed -e 's/\.aff//'` words/$platform/$language/gathered 2> regression/$platform/$commit\_$timestamp/$language/stderr | sed -e 's/^\(.\).*/\1/' > regression/$platform/$commit\_$timestamp/$language/gathered.spelling
			end=`date +%s`
			echo $end-$start|bc >> regression/$platform/$commit\_$timestamp/$language/time-$hostname.tsv

			# calculate total
			wc -l regression/$platform/$commit\_$timestamp/$language/gathered.spelling|awk '{print $1}'>regression/$platform/$commit\_$timestamp/$language/gathered.total

			if [ `cat words/$platform/$language/gathered.total` -eq `cat regression/$platform/$commit\_$timestamp/$language/gathered.total` ]; then
				# recombine list of output words and list of spelling result
				paste -d"\t" regression/$platform/$commit\_$timestamp/$language/gathered.spelling words/$platform/$language/gathered > regression/$platform/$commit\_$timestamp/$language/gathered.tsv

				# filter and calculate totals

				# correct
				grep '^[*+-]' regression/$platform/$commit\_$timestamp/$language/gathered.tsv|awk -F '\t' '{print $2}'>regression/$platform/$commit\_$timestamp/$language/gathered.correct
				wc -l regression/$platform/$commit\_$timestamp/$language/gathered.correct|awk '{print $1}'>regression/$platform/$commit\_$timestamp/$language/gathered.total_correct
				# incorrect
				grep '^[#&]' regression/$platform/$commit\_$timestamp/$language/gathered.tsv|awk -F '\t' '{print $2}'>regression/$platform/$commit\_$timestamp/$language/gathered.incorrect
				wc -l regression/$platform/$commit\_$timestamp/$language/gathered.incorrect|awk '{print $1}'>regression/$platform/$commit\_$timestamp/$language/gathered.total_incorrect
				# okay
				grep '^*' regression/$platform/$commit\_$timestamp/$language/gathered.tsv|awk -F '\t' '{print $2}'>regression/$platform/$commit\_$timestamp/$language/gathered.okay
				wc -l regression/$platform/$commit\_$timestamp/$language/gathered.okay|awk '{print $1}'>regression/$platform/$commit\_$timestamp/$language/gathered.total_okay
				# affixed
				grep '^+' regression/$platform/$commit\_$timestamp/$language/gathered.tsv|awk -F '\t' '{print $2}'>regression/$platform/$commit\_$timestamp/$language/gathered.affixed
				wc -l regression/$platform/$commit\_$timestamp/$language/gathered.affixed|awk '{print $1}'>regression/$platform/$commit\_$timestamp/$language/gathered.total_affixed
				# compounded
				grep '^-' regression/$platform/$commit\_$timestamp/$language/gathered.tsv|awk -F '\t' '{print $2}'>regression/$platform/$commit\_$timestamp/$language/gathered.compounded
				wc -l regression/$platform/$commit\_$timestamp/$language/gathered.compounded|awk '{print $1}'>regression/$platform/$commit\_$timestamp/$language/gathered.total_compounded
				# near miss
				grep '^&' regression/$platform/$commit\_$timestamp/$language/gathered.tsv|awk -F '\t' '{print $2}'>regression/$platform/$commit\_$timestamp/$language/gathered.nearmiss
				wc -l regression/$platform/$commit\_$timestamp/$language/gathered.nearmiss|awk '{print $1}'>regression/$platform/$commit\_$timestamp/$language/gathered.total_nearmiss
				#unknown
				grep '^#' regression/$platform/$commit\_$timestamp/$language/gathered.tsv|awk -F '\t' '{print $2}'>regression/$platform/$commit\_$timestamp/$language/gathered.unknown
				wc -l regression/$platform/$commit\_$timestamp/$language/gathered.unknown|awk '{print $1}'>regression/$platform/$commit\_$timestamp/$language/gathered.total_unknown

				# diff with reference
				if [ -e reference/$platform/$language ]; then




					cp -f reference/$platform/$language/gathered.total_correct regression/$platform/$commit\_$timestamp/$language/gathered.total_correct_src
					cp -f reference/$platform/$language/gathered.total_incorrect regression/$platform/$commit\_$timestamp/$language/gathered.total_incorrect_src

					comm -1 -2 reference/$platform/$language/gathered.correct regression/$platform/$commit\_$timestamp/$language/gathered.correct|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.confusion_true_pos
					comm -1 -2 reference/$platform/$language/gathered.incorrect regression/$platform/$commit\_$timestamp/$language/gathered.correct|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.confusion_false_pos

					comm -1 -2 reference/$platform/$language/gathered.correct regression/$platform/$commit\_$timestamp/$language/gathered.incorrect|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.confusion_false_neg
					comm -1 -2 reference/$platform/$language/gathered.incorrect regression/$platform/$commit\_$timestamp/$language/gathered.incorrect|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.confusion_true_neg




					cp -f reference/$platform/$language/gathered.total_okay regression/$platform/$commit\_$timestamp/$language/gathered.total_okay_src
					cp -f reference/$platform/$language/gathered.total_affixed regression/$platform/$commit\_$timestamp/$language/gathered.total_affixed_src
					cp -f reference/$platform/$language/gathered.total_compounded regression/$platform/$commit\_$timestamp/$language/gathered.total_compounded_src
					cp -f reference/$platform/$language/gathered.total_nearmiss regression/$platform/$commit\_$timestamp/$language/gathered.total_nearmiss_src
					cp -f reference/$platform/$language/gathered.total_unknown regression/$platform/$commit\_$timestamp/$language/gathered.total_unknown_src

					comm -1 -2 reference/$platform/$language/gathered.okay regression/$platform/$commit\_$timestamp/$language/gathered.okay|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.okay_okay
					comm -1 -2 reference/$platform/$language/gathered.okay regression/$platform/$commit\_$timestamp/$language/gathered.affixed|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.okay_affixed
					comm -1 -2 reference/$platform/$language/gathered.okay regression/$platform/$commit\_$timestamp/$language/gathered.compounded|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.okay_compounded
					comm -1 -2 reference/$platform/$language/gathered.okay regression/$platform/$commit\_$timestamp/$language/gathered.nearmiss|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.okay_nearmiss
					comm -1 -2 reference/$platform/$language/gathered.okay regression/$platform/$commit\_$timestamp/$language/gathered.unknown|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.okay_unknown

					comm -1 -2 reference/$platform/$language/gathered.affixed regression/$platform/$commit\_$timestamp/$language/gathered.okay|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.affixed_okay
					comm -1 -2 reference/$platform/$language/gathered.affixed regression/$platform/$commit\_$timestamp/$language/gathered.affixed|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.affixed_affixed
					comm -1 -2 reference/$platform/$language/gathered.affixed regression/$platform/$commit\_$timestamp/$language/gathered.compounded|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.affixed_compounded
					comm -1 -2 reference/$platform/$language/gathered.affixed regression/$platform/$commit\_$timestamp/$language/gathered.nearmiss|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.affixed_nearmiss
					comm -1 -2 reference/$platform/$language/gathered.affixed regression/$platform/$commit\_$timestamp/$language/gathered.unknown|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.affixed_unknown

					comm -1 -2 reference/$platform/$language/gathered.compounded regression/$platform/$commit\_$timestamp/$language/gathered.okay|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.compounded_okay
					comm -1 -2 reference/$platform/$language/gathered.compounded regression/$platform/$commit\_$timestamp/$language/gathered.affixed|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.compounded_affixed
					comm -1 -2 reference/$platform/$language/gathered.compounded regression/$platform/$commit\_$timestamp/$language/gathered.compounded|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.compounded_compounded
					comm -1 -2 reference/$platform/$language/gathered.compounded regression/$platform/$commit\_$timestamp/$language/gathered.nearmiss|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.compounded_nearmiss
					comm -1 -2 reference/$platform/$language/gathered.compounded regression/$platform/$commit\_$timestamp/$language/gathered.unknown|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.compounded_unknown

					comm -1 -2 reference/$platform/$language/gathered.nearmiss regression/$platform/$commit\_$timestamp/$language/gathered.okay|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.nearmiss_okay
					comm -1 -2 reference/$platform/$language/gathered.nearmiss regression/$platform/$commit\_$timestamp/$language/gathered.affixed|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.nearmiss_affixed
					comm -1 -2 reference/$platform/$language/gathered.nearmiss regression/$platform/$commit\_$timestamp/$language/gathered.compounded|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.nearmiss_compounded
					comm -1 -2 reference/$platform/$language/gathered.nearmiss regression/$platform/$commit\_$timestamp/$language/gathered.nearmiss|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.nearmiss_nearmiss
					comm -1 -2 reference/$platform/$language/gathered.nearmiss regression/$platform/$commit\_$timestamp/$language/gathered.unknown|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.nearmiss_unknown

					comm -1 -2 reference/$platform/$language/gathered.unknown regression/$platform/$commit\_$timestamp/$language/gathered.okay|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.unknown_okay
					comm -1 -2 reference/$platform/$language/gathered.unknown regression/$platform/$commit\_$timestamp/$language/gathered.affixed|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.unknown_affixed
					comm -1 -2 reference/$platform/$language/gathered.unknown regression/$platform/$commit\_$timestamp/$language/gathered.compounded|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.unknown_compounded
					comm -1 -2 reference/$platform/$language/gathered.unknown regression/$platform/$commit\_$timestamp/$language/gathered.nearmiss|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.unknown_nearmiss
					comm -1 -2 reference/$platform/$language/gathered.unknown regression/$platform/$commit\_$timestamp/$language/gathered.unknown|wc -l>regression/$platform/$commit\_$timestamp/$language/gathered.unknown_unknown



				fi

				echo -n ', scoring '
			    echo `cat regression/$platform/$commit\_$timestamp/$language/gathered.total_correct`'/'`cat words/$platform/$language/gathered.total`'*100'|bc -l|sed -e 's/\(\....\).*$/\1%/'
			else
				echo
				echo 'ERROR: Number of words in ('`cat words/$platform/$language/gathered.total`') and number of results out ('`cat regression/$platform/$commit\_$timestamp/$language/gathered.total`') do not match for '$language
			fi
		fi

	fi # warnings or errors in stderr

	fi # to speed up development of this script

	fi
done
total_end=`date +%s`
echo $total_end-$total_start|bc > regression/$platform/$commit\_$timestamp/time-$hostname