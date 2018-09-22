#!/usr/bin/env sh

exit
# under cosntruction

if [ -e current ]; then
	rm -rf current
fi
mkdir current

uname="$(uname -s)"
case "${uname}" in
	Linux*)
	platform=linux;;
	FreeBSD*)
	platform=freebsd;;
	Darwin*)
	platform=macos;;
	CYGWIN*)
	platform=cygwin;;
	MINGW*)
	platform=mingw;;
	*)
	platform="unknown:${uname}"
esac
hostname=`hostname`

for path in `find ../1-support/packages -type f -name '*.aff'|sort`; do
	package=`echo $path|awk -F '/' '{print $4}'`
	version=`echo $path|awk -F '/' '{print $5}'`
	affix=`echo $path|awk -F '/' '{print $9}'`
	language=`basename $affix .aff`

	if [ -e words/$language/gathered ]; then
		echo -n 'Running current Nuspell on gathered words for '$language
		mkdir -p current/$language
		../../nuspell/src/nuspell/nuspell -d `echo $path|sed -e 's/\.aff//'` words/$language/gathered > current/$language/gathered 2> /dev/null
		paste -d"\t" current/$language/gathered words/$language/gathered > current/$language/gathered.tsv
		grep '^&' current/$language/gathered|wc -l>current/$language/gathered.bad
		grep '^*' current/$language/gathered|wc -l>current/$language/gathered.good
		#TODO check also for not & and not *
		echo -n ', scoring '
		echo `cat current/$language/gathered.good`'/'`wc -l words/$language/gathered|awk '{print $1}'`'*100' | bc -l | sed -e 's/\(\....\).*$/\1%/'
		echo -n 'differs with Hunspell '
		# divide by 50 instead of 100 because diff reports doubles
		echo `diff -U 0 reference/$language/gathered current/$language/gathered|tail -n +3|grep -v '\@'|wc -l`'/'`wc -l words/$language/gathered|awk '{print $1}'`'*50' | bc -l | sed -e 's/\(\....\).*$/\1%/'
	fi
done
