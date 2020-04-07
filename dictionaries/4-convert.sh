#!/usr/bin/env sh

# description: Converst dictionaries to UTF-8
# license: https://github.com/nuspell/nuspell/blob/master/COPYING.LESSER
# author: Sander van Geloven

set -e
cd $(dirname "$0")
if [ ! -d extractions ]; then
	echo 'ERROR: Run the script ./2-extract.sh first.'
	exit 1
fi

if [ -e utf8 ]; then
	rm -rf utf8
fi
cd extractions

for i in $(ls|sort); do
	echo $i
	cd $i
	for DIC in $(ls *.dic|sort); do
		LANG=$(basename $DIC .dic)
		AFF=$LANG.aff
		if [ ! -e $AFF ]; then
			echo 'ERROR: Missing affix file for '$i/$DIC', probably skip its extraction and report upstream'
			continue
		fi
		mkdir -p ../../utf8/$i
		ENC=$(grep SET $AFF|grep -v ^#|head -n 1|awk '{print toupper($2)}'|tr -d '[:space:]')
		echo '\t'$AFF' (SET '$ENC')'
		FROM=$(file $AFF|sed -e 's/^.*: //')
		echo '\t\tfrom '$FROM
		iconv -f $ENC -t UTF-8 $AFF > ../../utf8/$i/$AFF
		if [ $(echo $FROM|grep -c 'line terminators') -ne 0 ]; then
			flip -ub ../../utf8/$i/$AFF
		fi
		echo '\t\tto   '$(file ../../utf8/$i/$AFF|sed -e 's/^.*: //')
		echo '\t'$DIC
		FROM=$(file $DIC|sed -e 's/^.*: //')
		echo '\t\tfrom '$FROM
		iconv -f $ENC -t UTF-8 $DIC > ../../utf8/$i/$DIC
		if [ $(echo $FROM|grep -c 'line terminators') -ne 0 ]; then
			flip -ub ../../utf8/$i/$DIC
		fi
		echo '\t\tto   '$(file ../../utf8/$i/$DIC|sed -e 's/^.*: //')
	done
	cd ..
done
echo 'Consider reporting conversion warnings and errors upstream'

cd ..

exit

#TODO incorporate exceptions from below


# fix slash+end-of-line
# gl_ES https://github.com/meixome/hunspell-gl/issues/257
# nb_NO https://bugs.documentfoundation.org/show_bug.cgi?id=119696
# lv_LV
# oc_FR
# an_ES https://github.com/apertium/apertium-arg/issues
# mkr_Latn
# es_ES not problem but better not
#if [ `grep -c '/$' $file` -ne 0 -a $filename != es_ES ]; then
#	echo 'WARNING: Removing trailing slash in '$file >> ../warnings.txt
#	sed -i -e 's/\/$//' $file
#fi


#			Encoding=`grep SET $affix|grep -v ^#|head -n 1|awk '{print toupper($2)}'|sed -e 's/ISO-/ISO/'|tr -d '[:space:]'`
#		fi

#	new_encoding=`file ../utf8/$filename.txt|sed -e 's/^.*: //'`
#	new_encoding=`file ../utf8/$filename.txt|sed -e 's/^.*: //'`
	#TODO report for an_ES to make non-data, see https://addons.mozilla.org/en-GB/firefox/addon/corrector-ortografico-aragones/
	#
#	if [ $filename = an_ES -a "$new_encoding" = 'data' -o "$new_encoding" = 'UTF-8 Unicode (with BOM) text' -o "$new_encoding" = 'UTF-8 Unicode text' -o "$new_encoding" = 'ASCII text' -o "$new_encoding" = 'UTF-8 Unicode text, with very long lines' ]; then
#		echo -n $encoding' | `' >> ../Dictionary-Files.md
#		echo `wc -l $file|awk '{print $1}'`'` |' >> ../Dictionary-Files.md
#	else
#		echo 'ERROR: File enconding conversion from '$encoding' for '$file' to '$new_encoding' for file '$filename' failed'
#		exit 1
#	fi
