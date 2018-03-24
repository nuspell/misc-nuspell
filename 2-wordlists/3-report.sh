#!/usr/bin/env bash

if [ -e packages ]; then
	cd packages
	echo 'This page has been generated on '`date +%Y-%m-%d`' at '`date +%H:%M`' by `misc-hunspell/2-wordlists/3-report.sh`. Do not edit this page manually. See also `Affix-file-analysis-of-publicly-available-dictionaries.md`, `Dictionaries-and-Contacts.md` and `Dictionary-Packages.md`' > ../Wordlist-Files.md #TODO

	echo >> ../Wordlist-Files.md

	echo '## Affix files' >> ../Wordlist-Files.md
	echo >> ../Wordlist-Files.md
	echo 'A total of '`find */*/usr/share/dict -type f|wc -l`' different wordlist files are available. Wordlist files which are made available via symbolic links are excluded. Note that each wordlist file has a unique name. Normally, these are installed in `/usr/share/dict/`. Note that medical word lists such as `wgerman-medical` and non-standard length word lists such as `wamerican-huge`, `wamerican-insane`, `wamerican-large`, `wamerican-small`, `wbritish-huge`, `wbritish-insane`, `wbritish-large`, `wbritish-small`, `wcanadian-huge`, `wcanadian-insane`, `wcanadian-large`, `wcanadian-small` and `scowl` are omitted.' >> ../Wordlist-Files.md
	echo >> ../Wordlist-Files.md
	echo '| Package | Version | Filename | Lines |' >> ../Wordlist-Files.md
	echo '|---|---|---|--:|' >> ../Wordlist-Files.md
	for file in `find */*/usr/share/dict -type f|sort`; do
		echo -n $file|sed -e 's/\/usr\/share\/dict//'|sed -e 's/^/| `/'|sed -e 's/\//` | `/g'|sed -e 's/$/`| `/' >> ../Wordlist-Files.md
		echo `wc -l $file|awk '{print $1}'`'` |' >> ../Wordlist-Files.md
	done

	cd ..

	echo '## File types' >> Wordlist-Files.md
	echo >> Wordlist-Files.md
	echo 'The following combinations of affix file and wordlist file have a different file type. This might be a problem in some cases.' >> Wordlist-Files.md
	echo >> Wordlist-Files.md
	echo '| Affix file | Affix file type | Wordlist file | Wordlist file type |' >> Wordlist-Files.md
	echo '|---|---|---|---|' >> Wordlist-Files.md
	for aff in `find ../1-support/packages/ -type f -name '*.aff'|sort`; do
		language=`basename $aff .aff`
		aff_type=`file $aff|sed -e 's/^.*: //'`
		wordlist=`../0-tools/hunspell_language_support_to_wordlist_name.sh $language`
		if [ `echo $wordlist|grep -c ERROR` == 0 ]; then
			package=`echo $wordlist|awk '{print $2}'`
			filename=`echo $wordlist|awk '{print $3}'`
			for wl in `find packages/$package/*/usr/share/dict/$filename -type f|sort`; do
				wl_type=`file $wl|sed -e 's/^.*: //'`
				if [ "$aff_type" != "$wl_type" ]; then
					echo '| `'$language'` | '$aff_type' | `'$filename'` | '$wl_type' |' >> Wordlist-Files.md
				fi
				break #TODO implement everywhere
			done
		fi
	done
fi
