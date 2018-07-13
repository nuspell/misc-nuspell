#!/usr/bin/env sh

# author: Sander van Geloven
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# description: downloads Wikipedia exports

download() {
	xml_name=`basename $2 .bz2`
	if [ -e $2 -o -e $xml_name ]; then
		echo 'INFO: Skipping '$2'...'
	else
		echo 'INFO: Downloading '$2'...'
		wget -q $1/$2
	fi
}


# English

#download https://dumps.wikimedia.org/enwiki/latest \
#	enwiki-latest-pages-articles-multistream.xml.bz2
#download https://dumps.wikimedia.org/enwiktionary/latest \
#	enwiktionary-latest-pages-articles-multistream.xml.bz2
#download https://dumps.wikimedia.org/enwikivoyage/latest \
#	enwikivoyage-latest-pages-articles-multistream.xml.bz2
#download https://dumps.wikimedia.org/enwikimedia/latest \
#	enwikimedia-latest-pages-articles-multistream.xml.bz2
#download https://dumps.wikimedia.org/enwikinews/latest \
#	enwikinews-latest-pages-articles-multistream.xml.bz2
#download https://dumps.wikimedia.org/enwikiversity/latest \
#	enwikiversity-latest-pages-articles-multistream.xml.bz2
##download https://dumps.wikimedia.org/enwikibooks/latest \
##	enwikibooks-latest-pages-articles-multistream.xml.bz2
##download https://dumps.wikimedia.org/enwikiquote/latest \
##	enwikiquote-latest-pages-articles-multistream.xml.bz2
##download https://dumps.wikimedia.org/enwikisource/latest \
##	enwikisource-latest-pages-articles-multistream.xml.bz2


# German

download https://dumps.wikimedia.org/dewiki/latest \
	dewiki-latest-pages-articles-multistream.xml.bz2
download https://dumps.wikimedia.org/dewiktionary/latest \
	dewiktionary-latest-pages-articles-multistream.xml.bz2
download https://dumps.wikimedia.org/dewikivoyage/latest \
	dewikivoyage-latest-pages-articles-multistream.xml.bz2
download https://dumps.wikimedia.org/dewikiversity/latest \
	dewikiversity-latest-pages-articles-multistream.xml.bz2
download https://dumps.wikimedia.org/dewikinews/latest \
	dewikinews-latest-pages-articles-multistream.xml.bz2
##download https://dumps.wikimedia.org/dewikibooks/latest \
##	dewikibooks-latest-pages-articles-multistream.xml.bz2
##download https://dumps.wikimedia.org/dewikiquote/latest \
##	dewikiquote-latest-pages-articles-multistream.xml.bz2
##download https://dumps.wikimedia.org/dewikisource/latest \
##	dewikisource-latest-pages-articles-multistream.xml.bz2


# Dutch

#download https://dumps.wikimedia.org/nlwiki/latest \
#	nlwiki-latest-pages-articles-multistream.xml.bz2
#download https://dumps.wikimedia.org/nlwiktionary/latest \
#	nlwiktionary-latest-pages-articles-multistream.xml.bz2
#download https://dumps.wikimedia.org/nlwikivoyage/latest \
#	nlwikivoyage-latest-pages-articles-multistream.xml.bz2
#download https://dumps.wikimedia.org/nlwikimedia/latest \
#	nlwikimedia-latest-pages-articles-multistream.xml.bz2
#download https://dumps.wikimedia.org/nlwikinews/latest \
#	nlwikinews-latest-pages-articles-multistream.xml.bz2
##download https://dumps.wikimedia.org/nlwikibooks/latest \
##	nlwikibooks-latest-pages-articles-multistream.xml.bz2
##download https://dumps.wikimedia.org/nlwikiquote/latest \
##	nlwikiquote-latest-pages-articles-multistream.xml.bz2
##download https://dumps.wikimedia.org/nlwikisource/latest \
##	nlwikisource-latest-pages-articles-multistream.xml.bz2


# Macedonian

#download https://dumps.wikimedia.org/mkwiki/latest \
#	mkwiki-latest-pages-articles-multistream.xml.bz2
#download https://dumps.wikimedia.org/mkwiktionary/latest \
#	mkwiktionary-latest-pages-articles-multistream.xml.bz2
#download https://dumps.wikimedia.org/mkwikimedia/latest \
#	mkwikimedia-latest-pages-articles-multistream.xml.bz2
##download https://dumps.wikimedia.org/mkwikibooks/latest \
##	mkwikibooks-latest-pages-articles-multistream.xml.bz2
##download https://dumps.wikimedia.org/mkwikisource/latest \
##	mkwikisource-latest-pages-articles-multistream.xml.bz2
