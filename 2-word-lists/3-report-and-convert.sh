#!/usr/bin/env bash

if [ -e packages ]; then
	cd packages
	echo 'This page has been generated on '`date +%Y-%m-%d`' at '`date +%H:%M`' by `misc-hunspell/2-word-lists/3-report.sh`. Do not edit this page manually. See also many other markdown documentation.' > ../Word-List-Files.md

	echo >> ../Word-List-Files.md

	echo '## Word List Files' >> ../Word-List-Files.md
	echo >> ../Word-List-Files.md
	echo 'A total of '`find */*/usr/share/dict -type f|wc -l`' different word list files are available. Word list files which are made available via symbolic links are excluded. Note that each word list file has a unique name. Normally, these are installed in `/usr/share/dict/`. Note that medical word lists such as `wgerman-medical` and non-standard length word lists such as `wamerican-huge`, `wamerican-insane`, `wamerican-large`, `wamerican-small`, `wbritish-huge`, `wbritish-insane`, `wbritish-large`, `wbritish-small`, `wcanadian-huge`, `wcanadian-insane`, `wcanadian-large`, `wcanadian-small` and `scowl` are omitted.' >> ../Word-List-Files.md
	echo >> ../Word-List-Files.md
	rm -rf ../utf8
	mkdir ../utf8
	echo '| Package | Version | Filename | Lines |' >> ../Word-List-Files.md
	echo '|---|---|---|--:|' >> ../Word-List-Files.md
	for file in `find */*/usr/share/dict -type f|sort`; do
		echo -n $file|sed -e 's/\/usr\/share\/dict//'|sed -e 's/^/| `/'|sed -e 's/\//` | `/g'|sed -e 's/$/` | /' >> ../Word-List-Files.md
		filename=`basename $file`
		echo $filename
		encoding=`file $file|sed -e 's/^.*: //'`
		echo -n $encoding' | `' >> ../Word-List-Files.md
		echo `wc -l $file|awk '{print $1}'`'` |' >> ../Word-List-Files.md
		if [ "$encoding" = 'UTF-8 Unicode text' -o "$encoding" = 'ASCII text' ]; then
			cp $file ../utf8/$filename.txt
		elif [ "$encoding" = 'ISO-8859 text' ]; then
			iconv -f ISO-8859-1 -t UTF-8//IGNORE $file -o ../utf8/$filename.txt
		else
			echo 'ERROR: Unsupported file encoding '$encoding
			exit 1
		fi
		../../0-tools/histogram.py ../utf8/$filename.txt > ../utf8/$filename-historgram.tsv
	done

	cd ..

	echo '## File types' >> Word-List-Files.md
	echo >> Word-List-Files.md
	echo 'The following combinations of affix file and word list file have a different file type. This might be a problem in some cases.' >> Word-List-Files.md
	echo >> Word-List-Files.md
	echo '| Affix File | Affix File Type | Word List File | Word List File Type |' >> Word-List-Files.md
	echo '|---|---|---|---|' >> Word-List-Files.md
	for aff in `find ../1-support/packages/ -type f -name '*.aff'|sort`; do
		language=`basename $aff .aff`
		aff_type=`file $aff|sed -e 's/^.*: //'|sed -e 's/, with very long lines//'`
		word_list=`../0-tools/hunspell_language_support_to_word_list_name.sh $language`
		if [ `echo $word_list|grep -c ERROR` == 0 ]; then
			package=`echo $word_list|awk '{print $2}'`
			filename=`echo $word_list|awk '{print $3}'`
			for wl in `find packages/$package/*/usr/share/dict/$filename -type f|sort`; do
				wl_type=`file $wl|sed -e 's/^.*: //'|sed -e 's/, with very long lines//'`
				if [ "$aff_type" != "$wl_type" ]; then
					if [ "$aff_type" = 'ASCII text' -a "$wl_type" = 'UTF-8 Unicode text' ] || [ "$aff_type" = 'UTF-8 Unicode text' -a "$wl_type" = 'ASCII text' ]; then
						echo -n
					else
						echo '| `'$language'` | '$aff_type' | `'$filename'` | '$wl_type' |' >> Word-List-Files.md
					fi
				fi
				break #TODO implement everywhere
			done
		fi
	done
fi
