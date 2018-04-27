#!/usr/bin/env bash

if [ ! -e checks ]
then
    mkdir checks
fi

hunspell_version=`../../hunspell/src/tools/hunspell --version|grep Hunspell|awk -F 'Hunspell ' '{print $2}'|sed 's/)//'`
for package in `ls ../1-support/packages/`
do
    echo 'package: '$package
    for version in `ls ../1-support/packages/$package/`
    do
        echo '  version: '$version
        for affix in `find ../1-support/packages/$package/$version/usr/share/hunspell/ -type f -name '*.aff'`
        do
            language=`echo $affix|sed 's/.*hunspell\/\(.*\)\.aff$/\1/'`
            wordlist=`../0-tools/hunspell_language_support_to_wordlist_name.sh $package $language`
            if [ `echo $wordlist|grep -c ERROR` == 0 ]; then
                echo '    language: '$language
                dict=`echo $affix|sed 's/\.aff$/\.dic/'`
                echo '    affix: '$affix
                echo '    dict: '$dict
                wordlist_package=`echo $wordlist|sed 's/\(.*\) .*/\1/'`
                wordlist_file=`echo $wordlist|sed 's/.* \(.*\)/\1/'`
                echo '    wordlist package: '$wordlist_package
                echo '    wordlist file: '$wordlist_file
                for wordlist_version in `ls ../2-wordlists/packages/$wordlist_package/`
                do
                    echo '      wordlist version: '$wordlist_version
                    for wordlist_path in `find ../2-wordlists/packages/$wordlist_package/$wordlist_version/usr/share/dict/ -type f -name $wordlist_file`  # Use find for file here, not ls. This will break if a dict file is replaced by a symbolic link. That will show up in the results and require changing ../0-tools/hunspell_language_support_to_wordlist_name.sh
                    do
                        echo '      wordlist size: '`wc -l $wordlist_path|awk '{print $1}'`
                        mkdir -p checks/$package/$version/$language/$wordlist_package/$wordlist_version/$wordlist_file/
                        ../../hunspell/src/tools/bulkcheck $affix $dict $wordlist_path >checks/$package/$version/$language/$wordlist_package/$wordlist_version/$wordlist_file/$hunspell_version.tsv 2>checks/$package/$version/$language/$wordlist_package/$wordlist_version/$wordlist_file/$hunspell_version\_report.tsv
                    done
                done
            fi
        done
    done
done
