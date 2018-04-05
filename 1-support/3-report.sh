#!/usr/bin/env bash

if [ -e packages ]; then
	cd packages
	echo 'This page has been generated on '`date +%Y-%m-%d`' at '`date +%H:%M`' by `misc-hunspell/1-support/3-report.sh`. Do not edit this page manually. See also `Affix-file-analysis-of-publicly-available-dictionaries.md`, `Dictionaries-and-Contacts.md` and `Dictionary-Packages.md`' > ../Dictionary-Files.md #TODO

	echo >> ../Dictionary-Files.md

	echo '## Affix files' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	echo 'A total of '`find . -type f -name '*.aff'|wc -l`' different affix files are available for Hunspell. Affix files which are made available via symbolic links are excluded. Note that each affix file has a unique name. Normally, these are installed in `/usr/share/hunspell/`.' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	echo 'Some available packages are omitted from this overview and testing framework. Package `hunspell-fr` is only a dependency package. Packages `hunspell-fr-classical`, `hunspell-fr-modern` and `hunspell-fr-revised` conflict with `hunspell-fr-comprehensive`, which has a bigger affix file. Package `hunspell-gl` conflicts with `hunspell-gl-es`, which has a bigger affix file.' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	echo '| Package | Version | Filename | Type | Lines |' >> ../Dictionary-Files.md
	echo '|---|---|---|---|--:|' >> ../Dictionary-Files.md
	for file in `find . -type f -name '*.aff'|sort`; do
		echo -n $file|sed -e 's/\/usr\/share\/hunspell//'|sed -e 's/^\.\//| `hunspell-/'|sed -e 's/\//` | `/g'|sed -e 's/$/` | /' >> ../Dictionary-Files.md
		echo -n `file $file|sed -e 's/^.*: //'`' | `' >> ../Dictionary-Files.md
		echo `wc -l $file|awk '{print $1}'`'` |' >> ../Dictionary-Files.md
	done

	echo >> ../Dictionary-Files.md

	echo '## Dictionary files' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	echo 'A total of '`find . -type f -name '*.dic'|wc -l`' different dictionary files are available for Hunspell. Dictionary files which are made available via symbolic links are excluded. Note that each dictionary file has a unique name. Normally, these are installed in `/usr/share/hunspell/`. Note that medical extention dictionary files, see `-med`, `_med` and `_MED`, do not have their own affix file. These dictionaries can be loaded additionally.' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	echo '| Package | Version | Filename | Type | Lines |' >> ../Dictionary-Files.md
	echo '|---|---|---|---|--:|' >> ../Dictionary-Files.md
	for file in `find . -type f -name '*.dic'|sort`; do
		echo -n $file|sed -e 's/\/usr\/share\/hunspell//'|sed -e 's/^\.\//| `hunspell-/'|sed -e 's/\//` | `/g'|sed -e 's/$/` | /' >> ../Dictionary-Files.md
		echo -n `file $file|sed -e 's/^.*: //'`' | `' >> ../Dictionary-Files.md
		echo `wc -l $file|awk '{print $1}'`'` |' >> ../Dictionary-Files.md
	done

	# bug fix
	sed -i -e 's/hunspell-fo/myspell-fo/' ../Dictionary-Files.md

	echo '## File types' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	echo 'The following pairs of affix file and dictionary file have a different file type. This might be a problem in some cases.' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	echo '| Language | Affix file type | Dictionary file type |' >> ../Dictionary-Files.md
	echo '|---|---|---|' >> ../Dictionary-Files.md
	for aff in `find . -type f -name '*.aff'|sort`; do
		language=`basename $aff .aff`
		aff_type=`file $aff|sed -e 's/^.*: //'`
		dic=`echo $aff|sed -e 's/\.aff$/\.dic/'`
		dic_type=`file $dic|sed -e 's/^.*: //'`
		if [ "$aff_type" != "$dic_type" ]; then
			echo '| `'$language'` | '$aff_type' | '$dic_type' |' >> ../Dictionary-Files.md
		fi
	done
fi
