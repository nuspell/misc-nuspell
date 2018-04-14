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
	updated=1 # updated=`git pull -r|grep -c 'Already up-to-date.'`
else
	git clone https://github.com/hunspell/nuspell.git
	cd nuspell
fi
commit=`git log|head -n 1|awk '{print $2}'`
if [ $updated -eq 0 ]; then
	autoreconf -vfi
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to automatically reconfigure nuspell'
		exit 1
	fi
	./configure
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to configure nuspell'
		exit 1
	fi
	make -j
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to build nuspell'
		exit 1
	fi
	make check
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to test nuspell'
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
		echo -n 'Running Hunspell on gathered words for '$language
		mkdir -p reference/$platform/$language
		start=`date +%s`
		if [ $language = 'nl_NL' ]; then
			../../nuspell/src/tools/hunspell -Y -i UTF-8 -d `echo $path|sed -e 's/\.aff//'` -a words/$platform/$language/gathered | tail -n +2 | grep -v '^$' | sed -e 's/^\(.\).*/\1/' > reference/$platform/$language/gathered
		else
			../../nuspell/src/tools/hunspell -Y -d `echo $path|sed -e 's/\.aff//'` -a words/$platform/$language/gathered | tail -n +2 | grep -v '^$' | sed -e 's/^\(.\).*/\1/' > reference/$platform/$language/gathered
		fi
		end=`date +%s`
		if [ `wc -l words/$platform/$language/gathered|awk '{print $1}'` -eq `wc -l reference/$platform/$language/gathered|awk '{print $1}'` ]; then
			echo $end-$start | bc > reference/$platform/$language/time-$hostname
			paste -d"\t" reference/$platform/$language/gathered words/$platform/$language/gathered > reference/$platform/$language/gathered.tsv
			grep '^*' reference/$platform/$language/gathered|wc -l>reference/$platform/$language/gathered.good
			grep '^&' reference/$platform/$language/gathered|wc -l>reference/$platform/$language/gathered.bad
			#TODO check also for not & and not *
			echo -n ', scoring '
			echo `cat reference/$platform/$language/gathered.good`'/'`wc -l words/$platform/$language/gathered|awk '{print $1}'`'*100' | bc -l | sed -e 's/\(\....\).*$/\1%/'
		else
			echo
			echo 'ERROR: Number of words in ('`wc -l words/$platform/$language/gathered|awk '{print $1}'`') and number of results out ('`wc -l reference/$platform/$language/gathered|awk '{print $1}'`') do not match for '$language
		fi
	fi
done
total_end=`date +%s`
echo $total_end-$total_start | bc > reference/$platform/time-$hostname
