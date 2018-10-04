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
	echo 'Afrikaans'
	;;
an | an_ES)
	echo 'Aragonese'
	;;
ar)
	echo 'Arabic'
	;;
be | be_BY)
	echo 'Belarusian'
	;;
bg | bg_BG)
	echo 'Bulgarian'
	;;
bn | bn_BD)
	echo 'Bengali'
	;;
bo)
	echo 'Classical Tibetan'
	;;
br | br_FR)
	echo 'Breton'
	;;
bs | bs_BA)
	echo 'Bosnian'
	;;
ca | ca_ES)
	echo 'Catalan'
	;;
ca_ES-valencia)
	echo 'Valencian'
	;;
cs | cs_CZ)
	echo 'Czech'
	;;
da | da_DK)
	echo 'Danish'
	;;
de_AT | de_AT_frami)
	echo 'Austrian German'
	;;
de_CH | de_CH_frami)
	echo 'Swiss German'
	;;
de_DE | de_DE_frami | de_BE | de_LU)
	echo 'German'
	;;
dz)
	echo 'Dzongkha'
	;;
el | el_GR)
	echo 'Modern Greek'
	;;
en_AU)
	echo 'Australian English'
	;;
en_CA)
	echo 'Canadian English'
	;;
en_GB)
	echo 'British English'
	;;
en_US)
	echo 'American English'
	;;
en_ZA)
	echo 'South African English'
	;;
eo)
	echo 'Esperanto'
	;;
es | es_ES | es_AR | es_BO | es_CL | es_CO | es_CR | es_CU | es_DO | es_EC | es_GT | es_HN | es_MX | es_NI | es_PA | es_PE | es_PR | es_PY | es_SV | es_US | es_UY | es_VE)
	echo 'Spanish'
	;;
et | et_EE)
	echo 'Estonian'
	;;
eu)
	echo 'Basque'
	;;
fa | fa_IR)
	echo 'Farsi'
	;;
fo | fo_FO)
	echo 'Faroese'
	;;
fr | fr_FR | fr_BE | fr_CA | fr_CH | fr_LU | fr_MC)
	echo 'French'
	;;
ga | ga_IE)
	echo 'Irish'
	;;
gd | gd_GB)
	echo 'Scottish Gaelic'
	;;
gl | gl_ES)
	echo 'Galician'
	;;
gv | gv_GB)
	echo 'Manx Gaelic'
	;;
gu | gu_IN)
	echo 'Gujarati'
	;;
gug | gug_PY)
	echo 'Guarani'
	;;
he | he_IL)
	echo 'Hebrew'
	;;
hi | hi_IN)
	echo 'Hindi'
	;;
hr | hr_HR)
	echo 'Croatian'
	;;
hu | hu_HU)
	echo 'Hungarian'
	;;
hy | hy_AM)
	echo 'Armenian'
	;;
is | is_IS)
	echo 'Icelandic'
	;;
it | it_IT | it_CH)
	echo 'Italian'
	;;
kk | kk_KZ)
	echo 'Kazakh'
	;;
kmr | kmr_Latn)
	echo 'Kurmanji (Latin script)'
	;;
ko)
	echo 'Korean'
	;;
lo | lo_LA)
	echo 'Laotian'
	;;
lt | lt_LT)
	echo 'Lithuanian'
	;;
lv | lv_LV)
	echo 'Latvian'
	;;
ml | ml_IN)
	echo 'Malayalam'
	;;
nb | nb_NO)
	echo 'Bokmål'
	;;
ne | ne_NP)
	echo 'Nepalese'
	;;
nl | nl_NL | nl_BE)
	echo 'Dutch'
	;;
nn | nn_NO)
	echo 'Nynorsk'
	;;
nr | nr_ZA)
	echo 'Ndebele'
	;;
ns | ns_ZA)
	echo 'Northern Sotho'
	;;
oc | oc_FR)
	echo 'Occitan'
	;;
pl | pl_PL)
	echo 'Polish'
	;;
pt_BR)
	echo 'Brazilian'
	;;
pt | pt_PT)
	echo 'Portuguese'
	;;
ro | ro_RO)
	echo 'Romanian'
	;;
ru | ru_RU)
	echo 'Russian'
	;;
se)
	echo 'North Sámi'
	;;
si | si_LK)
	echo 'Sinhala'
	;;
sk | sk_SK)
	echo 'Slovak'
	;;
sl | sl_SI)
	echo 'Slovene'
	;;
sq | sq_AL)
	echo 'Albanian'
	;;
sr | sr_RS)
	echo 'Serbian (Cyrillic script)'
	;;
sr_Latn_RS)
	echo 'Serbian (Latin script)'
	;;
ss | ss_ZA)
	echo 'Swazi'
	;;
st | st_ZA)
	echo 'Southern Sotho'
	;;
sv_FI)
	echo 'Finland Swedish'
	;;
sv | sv_SE)
	echo 'Swedish'
	;;
sw | sw_TZ)
	echo 'Swahili'
	;;
te | te_IN)
	echo 'Telugu'
	;;
th | th_TH)
	echo 'Thai'
	;;
tl)
	echo 'Tagalog'
	;;
tn | tn_ZA)
	echo 'Tswana'
	;;
ts | ts_ZA)
	echo 'Tsonga'
	;;
uk | uk_UA)
	echo 'Ukrainian'
	;;
uz | uz_UZ)
	echo 'Uzbek'
	;;
ve | ve_ZA)
	echo 'Venda'
	;;
vi | vi_VN)
	echo 'Vietnamese'
	;;
xh | xh_ZA)
	echo 'Xhosa'
	;;
zu | zu_ZA)
	echo 'Zulu'
	;;
*)
	echo 'ERROR: Unsupported language code '$1
	exit 1
	;;
esac
