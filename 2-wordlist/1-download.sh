#!/usr/bin/env bash

if [ -e debs ]
then
    rm -rf debs
fi
mkdir debs

for package in `ls ../1-usage/packages/`
do
#    echo 'package: '$package
    for language in `find ../1-usage/packages/$package/*/usr/share/hunspell/ -type f -name '*\.aff'|sed 's/.*hunspell\/\(.*\)\.aff$/\1/'`
    do
#        echo '  language: '$language
        wordlist=`../0-tools/hunspell_language_support_to_wordlist_name.sh $package $language|sed 's/\(.*\) .*/\1/'`
        if [ `echo $wordlist|grep -c ERROR` == 0 ]
        then
#            echo '  wordlist: '$wordlist
            cd debs
            apt-get download $wordlist
            cd ..
        fi
    done
done
