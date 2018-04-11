#!/usr/bin/env bash

if [ $# -ge 2 ]; then
	echo 'ERROR: Only one optional parameter indicating specific commit is allowed'
	exit 1
fi

platform=`../0-tools/platform.sh`
hostname=`hostname`

if [ ! -e regression/$platform ]; then
	mkdir -p regression/$platform
fi

updated=0
if [ -e nuspell ]; then
	cd nuspell
	updated=`git pull -r|grep -c 'Already up-to-date.'`
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

for path in `find ../1-support/packages -type f -name '*.aff'|sort`; do
	package=`echo $path|awk -F '/' '{print $4}'`
	version=`echo $path|awk -F '/' '{print $5}'`
	affix=`echo $path|awk -F '/' '{print $9}'`
	language=`basename $affix .aff`

	if [ -e words/$platform/$language/gathered ]; then
		test=1
		if [ -e regression/$platform/$language/time-$hostname.tsv ]; then
			if [ "`grep -c $commit regression/$platform/$language/time-$hostname.tsv`" = 1 ]; then
				test=0
			fi
		fi
		if [ -e regression/$platform/$language/correctness.tsv ]; then
			if [ "`grep -c $commit regression/$platform/$language/correctness.tsv`" = 1 ]; then
				test=0
			fi
		fi
		if [ $test -eq 1 ]; then
			echo -n 'Running Nuspell '$handle' on gathered words for '$language
			mkdir -p regression/$platform/$language/$commit
			start=`date +%s`
			if [ $language = 'nl_NL' ]; then
				nuspell/src/nuspell/nuspell -i UTF-8 -d `echo $path|sed -e 's/\.aff//'` words/$platform/$language/gathered 2> regression/$platform/$language/$commit/stderr | sed -e 's/^\(.\).*/\1/' > regression/$platform/$language/$commit/gathered
			else
				nuspell/src/nuspell/nuspell -d `echo $path|sed -e 's/\.aff//'` words/$platform/$language/gathered 2> regression/$platform/$language/$commit/stderr | sed -e 's/^\(.\).*/\1/' > regression/$platform/$language/$commit/gathered
			fi
			end=`date +%s`
			echo -ne $timestamp'\t'$commit'\t'$handle'\t' >> regression/$platform/$language/time-$hostname.tsv
			echo $end-$start | bc >> regression/$platform/$language/time-$hostname.tsv
			sort -n regression/$platform/$language/time-$hostname.tsv > tmp
			mv -f tmp regression/$platform/$language/time-$hostname.tsv
			rm -f tmp
			paste -d"\t" regression/$platform/$language/$commit/gathered words/$platform/$language/gathered > regression/$platform/$language/$commit/gathered.tsv
			grep '^*' regression/$platform/$language/$commit/gathered|wc -l>regression/$platform/$language/$commit/gathered.good
			grep '^&' regression/$platform/$language/$commit/gathered|wc -l>regression/$platform/$language/$commit/gathered.bad
			#TODO check also for not & and not *
			echo -n ', scoring '
			echo `cat regression/$platform/$language/$commit/gathered.good`'/'`wc -l words/$platform/$language/gathered|awk '{print $1}'`'*100' | bc -l | sed -e 's/\(\....\).*$/\1%/'
			echo -e $timestamp'\t'$commit'\t'$handle'\t'`cat regression/$platform/$language/$commit/gathered.good`'\t'`cat regression/$platform/$language/$commit/gathered.bad` >> regression/$platform/$language/correctness.tsv
			sort -n regression/$platform/$language/correctness.tsv > tmp
			mv -f tmp regression/$platform/$language/correctness.tsv
			rm -f tmp
		fi
	fi
done
