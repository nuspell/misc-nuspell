download() {
	xml_name=`basename $2 .bz2`
	if [ -e $2 -o -e $xml_name ]; then
		echo 'INFO: Skipping '$2'...'
	else
		echo 'INFO: Downloading '$2'...'
		wget -q $1/$2
	fi
}

download https://dumps.wikimedia.org/nlwiki/latest \
	nlwiki-latest-pages-articles-multistream.xml.bz2
download https://dumps.wikimedia.org/nlwiktionary/latest \
	nlwiktionary-latest-pages-articles-multistream.xml.bz2
download https://dumps.wikimedia.org/nlwikivoyage/latest \
	nlwikivoyage-latest-pages-articles-multistream.xml.bz2
download https://dumps.wikimedia.org/nlwikimedia/latest \
	nlwikimedia-latest-pages-articles-multistream.xml.bz2
download https://dumps.wikimedia.org/nlwikinews/latest \
	nlwikinews-latest-pages-articles-multistream.xml.bz2
##download https://dumps.wikimedia.org/nlwikibooks/latest \
##	nlwikibooks-latest-pages-articles-multistream.xml.bz2
##download https://dumps.wikimedia.org/nlwikiquote/latest \
##	nlwikiquote-latest-pages-articles-multistream.xml.bz2
##download https://dumps.wikimedia.org/nlwikisource/latest \
##	nlwikisource-latest-pages-articles-multistream.xml.bz2

download https://dumps.wikimedia.org/mkwiki/latest \
	mkwiki-latest-pages-articles-multistream.xml.bz2
download https://dumps.wikimedia.org/mkwiktionary/latest \
	mkwiktionary-latest-pages-articles-multistream.xml.bz2
download https://dumps.wikimedia.org/mkwikimedia/latest \
	mkwikimedia-latest-pages-articles-multistream.xml.bz2
#download https://dumps.wikimedia.org/mkwikibooks/latest \
#	mkwikibooks-latest-pages-articles-multistream.xml.bz2
#download https://dumps.wikimedia.org/mkwikisource/latest \
#	mkwikisource-latest-pages-articles-multistream.xml.bz2
