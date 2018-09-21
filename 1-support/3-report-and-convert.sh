#!/usr/bin/env sh

# description: reports on Hunspell language support
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# author: Sander van Geloven


# Initialization

if [ ! -d files ]; then
	echo 'ERROR: Run the script ./2-extract.sh first.'
    exit 1
fi
rm -f warnings.txt


# Generating report on dictionary files in markdown format

cd files
echo 'This page has been generated by `misc-hunspell/1-support/3-report.sh`. Do not edit this page manually. See also many other markdown documentation.' > ../Dictionary-Files.md

echo >> ../Dictionary-Files.md

echo '## Packages' >> ../Dictionary-Files.md
echo >> ../Dictionary-Files.md
echo 'The script `misc-hunspell/1-support/1-download.sh` will download the latest stable Hunspell and MySpell language support packages. Langauge support typically consists of an affix file and a dictionary file. Symbolic links are used to support some geografic regions where the particular language support also applies.' >> ../Dictionary-Files.md
echo >> ../Dictionary-Files.md
echo 'Some available packages are omitted from this overview and testing framework. Package `hunspell-fr` is only a dependency package. Packages `hunspell-fr-classical`, `hunspell-fr-modern` and `hunspell-fr-revised` conflict with `hunspell-fr-comprehensive`, which has a bigger affix file. Package `hunspell-gl` conflicts with `hunspell-gl-es`, which has a bigger affix file.' >> ../Dictionary-Files.md

echo >> ../Dictionary-Files.md

echo '## Affix files' >> ../Dictionary-Files.md
echo >> ../Dictionary-Files.md
echo 'A total of '`find . -type f -name '*.aff'|wc -l`' different affix files are available for Hunspell. Affix files which are made available via symbolic links are excluded. Note that each affix file has a unique name. Normally, these are installed in `/usr/share/hunspell/`.' >> ../Dictionary-Files.md
echo >> ../Dictionary-Files.md
echo '| Package | Version | Filename | File Type | Intended Encoding | Lines |' >> ../Dictionary-Files.md
echo '|---|---|---|---|---|--:|' >> ../Dictionary-Files.md
for file in `find . -type f -name '*.aff'|sort`; do
    # package, version and filename
	echo -n $file|sed -e 's/\/usr\/share\/hunspell\(.*\)\.aff/\1/'|sed -e 's/^\.\//| `/'|sed -e 's/\//` | `/g'|sed -e 's/$/` | /' >> ../Dictionary-Files.md
    # file type
	echo -n `file $file|sed -e 's/^.*: //'|sed -e 's/ text//'|sed -e 's/ Unicode//'`' | ' >> ../Dictionary-Files.md
    # intended encoding
    echo -n `grep SET $file|grep -v ^#|head -n 1|awk '{print $2}'|tr -d '[:space:]'`' | `' >>  ../Dictionary-Files.md
    # lines
	echo `wc -l $file|awk '{print $1}'`'` |' >> ../Dictionary-Files.md
done

echo >> ../Dictionary-Files.md

echo '## Dictionary files' >> ../Dictionary-Files.md
echo >> ../Dictionary-Files.md
echo 'A total of '`find . -type f -name '*.dic'|wc -l`' different dictionary files are available for Hunspell. Dictionary files which are made available via symbolic links are excluded. Note that each dictionary file has a unique name. Normally, these are installed in `/usr/share/hunspell/`. Note that medical extention dictionary files, see `-med`, `_med` and `_MED`, do not have their own affix file. These dictionaries can be loaded additionally.' >> ../Dictionary-Files.md
echo >> ../Dictionary-Files.md

if [ -e ../utf8 ]; then
    rm -f ../utf8/*
else
    mkdir ../utf8
fi

echo '| Package | Version | Filename | File Type | Lines |' >> ../Dictionary-Files.md
echo '|---|---|---|---|--:|' >> ../Dictionary-Files.md
for file in `find . -type f -name '*.dic'|sort`; do
	echo -n $file|sed -e 's/\/usr\/share\/hunspell//'|sed -e 's/^\.\//| `/'|sed -e 's/\//` | `/g'|sed -e 's/$/` | /' >> ../Dictionary-Files.md
	filename=`basename $file .dic`
	echo -n $filename

	# crude encoding
	encoding=`file $file|sed -e 's/^.*: //'|sed -e 's/ text//'|sed -e 's/ Unicode//'`

	# fix space+slash+space
	# https://github.com/meixome/hunspell-gl/issues/256
	if [ `grep -c ' / ' $file` -ne 0 ]; then
		echo 'WARNING: Replacing " / " with " + " in '$file >> ../warnings.txt
		sed -i -e 's/ \/ / + /g' $file
	fi

	# fix slash+end-of-line
	# gl_ES https://github.com/meixome/hunspell-gl/issues/257
	# nb_NO https://bugs.documentfoundation.org/show_bug.cgi?id=119696
	# lv_LV
	# oc_FR
	# an_ES https://github.com/apertium/apertium-arg/issues
	# mkr_Latn
	# es_ES not problem but better not
	if [ `grep -c '/$' $file` -ne 0 -a $filename != 'es_ES' ]; then
		echo 'WARNING: Removing trailing slash in '$file >> ../warnings.txt
		sed -i -e 's/\/$//' $file
	fi

        affix=`echo $file|sed -e 's/\.dic$/\.aff/'`
        if [ -e $affix ]; then
		# intended encoding
		# https://bugs.documentfoundation.org/show_bug.cgi?id=117392
		# bug bg_BG.aff:SET microsoft-cp1251 -> CP1251
		Encoding=`grep SET $affix|grep -v ^#|head -n 1|awk '{print toupper($2)}'|sed -e 's/ISO-/ISO/'|sed -e 's/MICROSOFT-//'|tr -d '[:space:]'`

		# autoskip medial when no aff file exists
		#TODO check match crude
		#TODO check iconv
        elif [ $filename = de_med -o $filename = en_MED ]; then
		Encoding=ISO8859-1
        else
		echo 'ERROR'
		exit 1
	fi
        echo '\t'$Encoding
        if [ $Encoding = UTF-8 ]; then
		cp $file ../utf8/$filename.txt
		cp $affix ../utf8/
        else
		iconv -f $Encoding -t UTF-8//IGNORE $file > ../utf8/$filename.txt
        fi

	new_encoding=`file ../utf8/$filename.txt|sed -e 's/^.*: //'`
	if [ "$new_encoding" = 'UTF-8 Unicode text, with CRLF line terminators' -o "$new_encoding" = 'UTF-8 Unicode text, with CRLF, LF line terminators' -o "$new_encoding" = 'UTF-8 Unicode (with BOM) text, with CRLF line terminators' -o "$new_encoding" = 'UTF-8 Unicode (with BOM) text, with CRLF, LF line terminators' ]; then
		flip -b -u ../utf8/$filename.txt
		echo 'WARNING: Fixing line terminators in '$file >> ../warnings.txt
	fi

	new_encoding=`file ../utf8/$filename.txt|sed -e 's/^.*: //'`
	#TODO report for an_ES to make non-data, see https://addons.mozilla.org/en-GB/firefox/addon/corrector-ortografico-aragones/
	#
	if [ $filename = an_ES -a "$new_encoding" = 'data' -o "$new_encoding" = 'UTF-8 Unicode (with BOM) text' -o "$new_encoding" = 'UTF-8 Unicode text' -o "$new_encoding" = 'ASCII text' -o "$new_encoding" = 'UTF-8 Unicode text, with very long lines' ]; then
		echo -n $encoding' | `' >> ../Dictionary-Files.md
		echo `wc -l $file|awk '{print $1}'`'` |' >> ../Dictionary-Files.md
	else
		echo 'ERROR: File enconding conversion from '$encoding' for '$file' to '$new_encoding' for file '$filename' failed'
		exit 1
	fi

done

echo '## File types' >> ../Dictionary-Files.md
echo >> ../Dictionary-Files.md
echo 'The following pairs of affix file and dictionary file have a different file type. This might be a problem in some cases.' >> ../Dictionary-Files.md
echo >> ../Dictionary-Files.md
echo '| Language | Affix file type | Dictionary file type |' >> ../Dictionary-Files.md
echo '|---|---|---|' >> ../Dictionary-Files.md
for aff in `find . -type f -name '*.aff'|sort`; do
	language=`basename $aff .aff`
	aff_type=`file $aff|sed -e 's/^.*: //'|sed -e 's/, with very long lines//'`
	dic=`echo $aff|sed -e 's/\.aff$/\.dic/'`
	dic_type=`file $dic|sed -e 's/^.*: //'|sed -e 's/, with very long lines//'`
	if [ "$aff_type" != "$dic_type" ]; then
		if [ "$aff_type" = 'ASCII text' -a "$dic_type" = 'UTF-8 Unicode text' ] || [ "$aff_type" = 'UTF-8 Unicode text' -a "$dic_type" = 'ASCII text' ]; then
			echo -n
		else
			echo '| `'$language'` | '$aff_type' | '$dic_type' |' >> ../Dictionary-Files.md
		fi
	fi
done

cd ..
more warnings.txt
