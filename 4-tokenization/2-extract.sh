# See https://github.com/attardi/wikiextractor

extract() {
	if [ -e $1 ]; then
		echo 'INFO: Extracting '$1'...'
		bunzip2 $1
	else
		echo 'INFO: Skipping '$1'...'
	fi
	xml_name=`basename $1 .bz2`
	base_name=`basename $xml_name .xml`
	if [ -e $xml_name ]; then
		echo 'INFO: Wiki extracting '$xml_name'...'
		rm -rf $base_name
		WikiExtractor.py \
--output $base_name \
--filter_disambig_pages \
--no-templates \
-de applet,code,gallery,imagemap,inputbox,mapframe,source,timeline,quiz \
--ignored_tags a,at,\
b,big,blockquote,br,\
center,cite,Contactpersoon,\
Datum,dd,div,dl,do,drink,dt,DynamicPageList,\
eat,em,\
font,\
h1,h2,h3,h4,h5,h6,hiero,hr,html,\
i,Inhoudsopgave,\
kbd,\
label,li,listing,\
mailadres,\
noinclude,nowiki,\
ol,onlyinclude,organisatie,\
p,poem,pre,\
ref,\
s,see,section,sleep,small,span,strike,strong,sub,sup,\
table,td,th,tr,tt,\
u,ul,\
var \
--processes 4 \
--quiet \
$xml_name

#--bytes 128M \

# Minimum expanded text length required to write document (default=0)
#--min_text_length MIN_TEXT_LENGTH

	else
		echo 'ERROR: Missing XML file '$xml_name'...'
	fi
}

extract nlwiki-latest-pages-articles-multistream.xml.bz2
extract nlwiktionary-latest-pages-articles-multistream.xml.bz2
extract nlwikivoyage-latest-pages-articles-multistream.xml.bz2
extract nlwikimedia-latest-pages-articles-multistream.xml.bz2
extract nlwikinews-latest-pages-articles-multistream.xml.bz2
##extract nlwikibooks-latest-pages-articles-multistream.xml.bz2
##extract nlwikiquote-latest-pages-articles-multistream.xml.bz2
##extract nlwikisource-latest-pages-articles-multistream.xml.bz2

extract mkwiki-latest-pages-articles-multistream.xml.bz2
extract mkwiktionary-latest-pages-articles-multistream.xml.bz2
extract mkwikimedia-latest-pages-articles-multistream.xml.bz2
##extract mkwikibooks-latest-pages-articles-multistream.xml.bz2
##extract mkwikisource-latest-pages-articles-multistream.xml.bz2