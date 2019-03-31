#!/usr/bin/env sh

for j in `find . -type d -name '??*'`; do
	cd $j
	for i in *.tsv; do
#		echo $i'\t'`wc -l $i|awk '{print $1}'`
		awk -F '\t' '{print $1}' $i>/tmp/$i.1
		if [ `wc -l $i|awk '{print $1}'` -ne `sort /tmp/$i.1|uniq|wc -l|awk '{print $1}'` ]; then
			echo 'ERROR: Entries not unique for '$j'/'$i
			sort /tmp/$i.1|uniq -c|grep -v '^      1 '
		fi
	#	awk -F '\t' '{print $2}' $i>/tmp/$i.2
	#FIXME	diff -y --suppress-common-lines /tmp/$i.1 /tmp/$i.2|wc -l
	done
	cd ..
done
