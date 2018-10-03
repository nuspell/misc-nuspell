#!/usr/bin/env sh

# description: Converts a Hunspell language support in terms of Debian/Ubuntu
# package language code and Hunspell's dictionary language code to a wordlist
# package name and wordlist file name. The Hunspell dictionary language code
# can be found in filenames in .aff or .dic files in /usr/share/hunspell/. The
# wordlist filenames can be found in /usr/share/dict/*. For example, package
# en-us with language en_US is converted to wordlist package name wamerican
# and wordlist filename american-english. Another example is de-ch-frami with
# de_CH_frami which converts to wswiss swiss.
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# author: Pander <pander@users.sourceforge.net>

#TODO Rewrite this scripts as Python 3 script in order for analyse.py to use
# it and make it platform independent.

#TODO Support all Hunspell languages and dictionary files.
# wogerman wgerman-medical
# wmanx
# dict-freedict-afr-eng dict-freedict-ara-eng dict-freedict-bre-fra
# dict-freedict-isl-eng dict-freedict-lit-eng dict-freedict-nno-nob
# dict-freedict-oci-cat
# apertium-arg apertium-br-fr apertium-eu-en apertium-kaz apertium-nno

if [ $# -ne 1 ]
then
	echo 'ERROR: Missing language code'
	exit 1
fi

case $1 in
af | af_ZA)
	echo $1'\t_\t_\tAfrikaans'
	;;
an | an_ES)
	echo $1'\t_\t_\tAragonese'
	;;
ar)
	echo $1'\t_\t_\tArabic'
	;;
be | be_BY)
	echo $1'\t_\t_\tBelarusian'
	;;
bg | bg_BG)
	echo $1'\twbulgarian\tbulgarian\tBulgarian'
	;;
ca | ca_ES | ca_ES-valencia)
	echo $1'\twcatalan\tcatala\tCatalan'  #FIXME Reverse symbolic link and file.
	;;
da | da_DK)
	echo $1'\twdanish\tdanish\tDanish'
	;;
de_AT | de_AT_frami)
	echo $1'\t_\t_\tAustrian German'
	;;
de_CH | de_CH_frami)
	echo $1'\twswiss\tswiss\tSwiss German'
	;;
#FIXME    de_BE)
#FIXME    de_LU)
de_DE | de_DE_frami)
	echo $1'\twngerman\tngerman\tGerman'
	;;
dz)
	echo $1'\t_\t_\tDzongkha'
	;;
el | el_GR)
	echo $1'\t_\t_\tModern Greek'
	;;
en_AU)
	echo $1'\t_\t_\tAustralian English'
	;;
en_CA)
	# wcanadian-huge wcanadian-insane wcanadian-large wcanadian-small
	echo $1'\twcanadian\tcanadian-english\tCanadian English'
	;;
en_GB)
	# wbritish-huge wbritish-insane wbritish-large wbritish-small
	echo $1'\twbritish\tbritish-english\tBritish English'
	;;
en_US)
	# wamerican-huge wamerican-insane wamerican-large wamerican-small
	echo $1'\twamerican\tamerican-english\tAmerican English'
	;;
eo)
	echo $1'\twesperanto\tesperanto\tEsperanto'
	;;
#FIXME    es_AR)
#FIXME    es_BO)
#FIXME    es_CL)
#FIXME    es_CO)
#FIXME    es_CR)
#FIXME    es_CU)
#FIXME    es_DO)
#FIXME    es_EC)
#FIXME    es_GT)
#FIXME    es_HN)
#FIXME    es_MX)
#FIXME    es_NI)
#FIXME    es_PA)
#FIXME    es_PE)
#FIXME    es_PR)
#FIXME    es_PY)
#FIXME    es_SV)
#FIXME    es_US)
#FIXME    es_UY)
#FIXME    es_VE)
es | es_ES)
	echo $1'\twspanish\tspanish\tSpanish'
	;;
et | et_EE)
	echo $1'\t_\t_\tEstonian'
	;;
fa | fa_IR)
	echo $1'\t_\t_\tFarsi'
	;;
fo | fo_FO)
	echo $1'\twfaroese\tfaroese\tFaroese'
	;;
#FIXME    fr_BE)
#FIXME    fr_CA)
#FIXME    fr_CH)
#FIXME    fr_FR)
#FIXME    fr_LU)
#FIXME    fr_MC)
fr)
	echo $1'\twfrench\tfrench\tFrench'
	;;
ga_IE)
	echo $1'\twirish\tirish\tIrish'
	;;
gd | gd_GB)
	echo $1'\twgaelic\tgaelic\tScottish Gaelic'
	;;
gl | gl_ES)
	echo $1'\twgalician-minimos\tgalician-minimos\tGalician'
	;;
gv | gv_GB)
	echo $1'\twmanx\tmanx\tManx Gaelic'
	;;
he)
	echo $1'\t_\t_\tHebrew'
	;;
hr)
	echo $1'\t_\t_\tCroatian'
	;;
hu)
	echo $1'\t_\t_\tHungarian'
	;;
hy | hy_AM)
	echo $1'\t_\t_\tArmenian'
	;;
is | is_IS)
	echo $1'\t_\t_\tIcelandic'
	;;
#FIXME    it_CH)
it | it_IT)
	echo $1'\twitalian\titalian\tItalian'
	;;
kk | kk_KZ)
	echo $1'\t_\t_\tKazakh'
	;;
kmr | kmr_Latn)
	echo $1'\t_\t_\tKurmanji'
	;;
ko)
	echo $1'\t_\t_\tKorean'
	;;
lo | lo_LA)
	echo $1'\t_\t_\tLaotian'
	;;
lt | lt_LT)
	echo $1'\t_\t_\tLithuanian'
	;;
lv | lv_LV)
	echo $1'\t_\t_\tLatvian'
	;;
ml | ml_IN)
	echo $1'\t_\t_\tMalayalam'
	;;
nl | nl_NL | nl_BE)
	echo $1'\twdutch\tdutch\tDutch'
	;;
nb_NO)
	echo $1'\twnorwegian\tbokmaal\tBokmål'
	;;
nn_NO)
	#FIXME norsk -> /etc/dictionaries-common/norsk Is this correct? Not nynorsk?
	echo $1'\twnorwegian\tnynorsk\tNynorsk'
	;;
nr | nr_ZA)
	echo $1'\t_\t_\tNdebele'
	;;
ns | ns_ZA)
	echo $1'\t_\t_\tNorthern Sotho'
	;;
oc | oc_FR)
	echo $1'\twpolish\tpolish\tOccitan'
	;;
pl | pl_PL)
	echo $1'\twpolish\tpolish\tPolish'
	;;
pt_BR)
	echo $1'\twbrazilian\tbrazilian\tBrazilian'
	;;
pt | pt_PT)
	echo $1'\twportuguese\tportuguese\tPortuguese'
	;;
ro | ro_RO)
	echo $1'\t_\t_\tRomanian'
	;;
ru | ru_RU)
	echo $1'\t_\t_\tRussian'
	;;
se)
	echo $1'\t_\t_\tNorth Sámi'
	;;
si | si_LK)
	echo $1'\t_\t_\tSinhala'
	;;
sk | sk_SK)
	echo $1'\t_\t_\tSlovak'
	;;
sl | sl_SL)
	echo $1'\t_\t_\tSlovene'
	;;
sq | sq_AL)
	echo $1'\t_\t_\tAlbanian'
	;;
ss | ss_ZA)
	echo $1'\t_\t_\tSwazi'
	;;
st | st_ZA)
	echo $1'\t_\t_\tSouthern Sotho'
	;;
sv | sv_SE)
	echo $1'\twswedish\tswedish\tSwedish'
	;;
sw | sw_TZ)
	echo $1'\t_\t_\tSwahili'
	;;
te | te_IN)
	echo $1'\t_\t_\tTelugu'
	;;
th | th_TH)
	echo $1'\t_\t_\tThai'
	;;
tl)
	echo $1'\t_\t_\tTagalog'
	;;
tn | tn_ZA)
	echo $1'\t_\t_\tTswana'
	;;
ts | ts_ZA)
	echo $1'\t_\t_\tTsonga'
	;;
uk | uk_UA)
	echo $1'\twukrainian\tukrainian\tUkrainian'
	;;
uz | uz_UZ)
	echo $1'\t_\t_\tUzbek'
	;;
ve | ve_ZA)
	echo $1'\t_\t_\tVenda'
	;;
vi | vi_VN)
	echo $1'\t_\t_\tVietnamese'
	;;
xh | xh_ZA)
	echo $1'\t_\t_\tXhosa'
	;;
zu | zu_ZA)
	echo $1'\t_\t_\tZulu'
	;;
*)
	echo 'ERROR: Unsupported package '$1
	exit 1
	;;
esac
