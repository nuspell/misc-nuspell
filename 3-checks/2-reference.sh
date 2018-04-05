#!/usr/bin/env bash

if [ -e reference ]; then
	rm -rf reference/*
else
	mkdir reference
fi

for path in `find ../1-support/packages -type f -name '*.aff'|sort`; do
	package=`echo $path|awk -F '/' '{print $4}'`
	version=`echo $path|awk -F '/' '{print $5}'`
	affix=`echo $path|awk -F '/' '{print $9}'`
	language=`basename $affix .aff`

	if [ -e words/$language/gathered ]; then
		echo -n 'Running Hunspell on gathered words for '$language
		mkdir -p reference/$language
		if [ $language = 'nl_NL' ]; then
			../../nuspell/src/tools/hunspell -i UTF-8 -d `echo $path|sed -e 's/\.aff//'` -a words/$language/gathered | tail -n +2 | grep -v '^$' | sed -e 's/^\(.\).*/\1/' > reference/$language/gathered
		else
			../../nuspell/src/tools/hunspell -d `echo $path|sed -e 's/\.aff//'` -a words/$language/gathered | tail -n +2 | grep -v '^$' | sed -e 's/^\(.\).*/\1/' > reference/$language/gathered
		fi
		paste -d"\t" reference/$language/gathered words/$language/gathered > reference/$language/gathered.tsv
		grep '^&' reference/$language/gathered|wc -l>reference/$language/gathered.bad
		grep '^*' reference/$language/gathered|wc -l>reference/$language/gathered.good
		#TODO check also for not & and not *
		echo -n ', scoring '
		echo `cat reference/$language/gathered.good`'/'`wc -l words/$language/gathered|awk '{print $1}'`'*100' | bc -l | sed -e 's/\(\....\).*$/\1%/'
	fi
done
