#!/usr/bin/env sh

# description: report on word lists and convert files to UTF-8
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# author: Sander van Geloven

if [ ! -d files ]; then
	echo 'ERROR: Run the script ./2-extract.sh first.'
    exit 1
fi

cd files
echo 'This page has been generated by `misc-hunspell/2-word-lists/3-report.sh`. Do not edit this page manually. See also many other markdown documentation.' > ../Word-List-Files.md

echo >> ../Word-List-Files.md

echo '## Word List Files' >> ../Word-List-Files.md
echo >> ../Word-List-Files.md
echo 'A total of '`find */*/usr/share/dict -type f|wc -l`' different word list files are available. Word list files which are made available via symbolic links are excluded. Note that each word list file has a unique name. Normally, these are installed in `/usr/share/dict/`. Note that medical word lists such as `wgerman-medical` and non-standard length word lists such as `wamerican-huge`, `wamerican-insane`, `wamerican-large`, `wamerican-small`, `wbritish-huge`, `wbritish-insane`, `wbritish-large`, `wbritish-small`, `wcanadian-huge`, `wcanadian-insane`, `wcanadian-large`, `wcanadian-small` and `scowl` are omitted. Please, note that for many of the files not yet in Unicode format, bug reports have already been filed and most of those have already been fixed in upcoming releases of the packages by which these files get shipped. See also [[Dictionaries-and-Contacts]].' >> ../Word-List-Files.md
echo >> ../Word-List-Files.md

if [ -d ../utf8 ]; then
    rm -f ../utf8/*
else
    mkdir ../utf8
fi

echo '| Package | Version | Filename | Filetype | Lines |' >> ../Word-List-Files.md
echo '|---|---|---|---|--:|' >> ../Word-List-Files.md
for file in `find */*/usr/share/dict -type f|sort`; do
	echo -n $file|sed -e 's/\/usr\/share\/dict//'|sed -e 's/^/| `/'|sed -e 's/\//` | `/g'|sed -e 's/$/` | /' >> ../Word-List-Files.md
	filename=`basename $file`
	echo $filename
	encoding=`file $file|sed -e 's/^.*: //'|sed -e 's/ Unicode//'|sed -e 's/ text//'`
	echo -n $encoding' | `' >> ../Word-List-Files.md
	echo `wc -l $file|awk '{print $1}'`'` |' >> ../Word-List-Files.md
	if [ $filename = american-english -o $filename = british-english -o $filename = canadian-english -o $filename = catalan -o $filename = danish -o $filename = dutch -o $filename = esperanto -o $filename = french -o $filename = galician-minimos -o $filename = italian -o $filename = klingon -o $filename = klingon-latin -o $filename = ngerman -o $filename = polish -o $filename = portuguese -o $filename = spanish -o $filename = swiss -o $filename = ukrainian ]; then
			cp $file ../utf8/$filename.txt
	elif [ $filename = brazilian -o $filename = faroese -o $filename = gaelic -o $filename = irish -o $filename = manx -o $filename = bokmaal -o $filename = nynorsk -o $filename = swedish ]; then
		iconv -f ISO-8859-1 -t UTF-8//IGNORE $file -o ../utf8/$filename.txt
	elif [ $filename = bulgarian ]; then
		iconv -f CP1251 -t UTF-8//IGNORE $file -o ../utf8/$filename.txt
	else
		echo 'ERROR: Unsupported file encoding '$encoding' for file '$file
		exit 1
	fi

	if [ $filename = irish ]; then # bug /E has to go, see comments below
		sed -i -e 's/\/.*$//' ../utf8/$filename.txt

#wirish 2.0-25
#/usr/share/dict/irish 
#314 lines
#achomharcainn/E
#adhlacainn/E
#adhmhillinn/E

	fi

	#TODO double check all is UTF-8

	../../0-tools/histogram.py ../utf8/$filename.txt > ../utf8/$filename-historgram.md
done

cd ..

echo >> Word-List-Files.md

echo '## File types' >> Word-List-Files.md
echo >> Word-List-Files.md
echo 'The following combinations of affix file and word list file have a different file type. This might be a problem in some cases. Please, note that for many of these differences bug reports have already been filed and most of the issues have already be taken care of in upcoming releases of the packages by which these files get shipped. See also [[Dictionaries-and-Contacts]].' >> Word-List-Files.md
echo >> Word-List-Files.md
echo '| Affix File | Affix File Type | Word List File | Word List File Type |' >> Word-List-Files.md
echo '|---|---|---|---|' >> Word-List-Files.md
for aff in `find ../1-support/files/ -type f -name '*.aff'|sort`; do
	language=`basename $aff .aff`
	aff_type=`file $aff|sed -e 's/^.*: //'|sed -e 's/ Unicode//'|sed -e 's/ text//'|sed -e 's/, with very long lines//'`
	word_list=`../0-tools/language_support_to_word_list_name.sh $language`
	if [ `echo $word_list|grep -c ERROR` = 0 ]; then
		package=`echo $word_list|awk '{print $2}'`
		filename=`echo $word_list|awk '{print $3}'`
		for wl in `find files/$package/*/usr/share/dict/$filename -type f|sort`; do
			wl_type=`file $wl|sed -e 's/^.*: //'|sed -e 's/ Unicode//'|sed -e 's/ text//'|sed -e 's/, with very long lines//'`
			if [ "$aff_type" != "$wl_type" ]; then
				if [ "$aff_type" = 'ASCII text' -a "$wl_type" = 'UTF-8 Unicode text' ]; then
					echo -n
				elif [ "$aff_type" = 'UTF-8 Unicode text' -a "$wl_type" = 'ASCII text' ]; then
					echo -n
				else
					echo '| `'$language'` | '$aff_type' | `'$filename'` | '$wl_type' |' >> Word-List-Files.md
				fi
			fi
			break #TODO implement everywhere
		done
	fi
done
