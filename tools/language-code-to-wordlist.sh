#!/usr/bin/env sh

# description: Converts language code of a dictionary to word list name
# license: https://github.com/nuspell/nuspell/blob/master/COPYING.LESSER
# author: Sander van Geloven

if [ $# -ne 1 ]
then
	echo 'ERROR: Missing language code'
	exit 1
fi

case $1 in
bg | bg_BG)
	echo $1'\twbulgarian\tbulgarian'
	;;
ca | ca_ES | ca_ES-valencia)
	echo $1'\twcatalan\tcatalan'
	;;
da | da_DK)
	echo $1'\twdanish\tdanish'
	;;
de_CH | de_CH_frami)
	echo $1'\twswiss\tswiss'
	;;
de_DE | de_DE_frami | de_AT | de_AT_frami | de_BE | de_LU)
	echo $1'\twngerman\tngerman'
	;;
de_DE-1901)
	echo $1'\twogerman\togerman'
	;;
en_CA)
	# wcanadian-huge wcanadian-insane wcanadian-large wcanadian-small
	echo $1'\twcanadian\tcanadian-english'
	;;
en_GB)
	# wbritish-huge wbritish-insane wbritish-large wbritish-small
	echo $1'\twbritish\tbritish-english'
	;;
en_US)
	# wamerican-huge wamerican-insane wamerican-large wamerican-small
	echo $1'\twamerican\tamerican-english'
	;;
eo)
	echo $1'\twesperanto\tesperanto'
	;;
es | es_ES | es_AR | es_BO | es_CL | es_CO | es_CR | es_CU | es_DO | es_EC | es_GT | es_HN | es_MX | es_NI | es_PA | es_PE | es_PR | es_PY | es_SV | es_US | es_UY | es_VE)
	echo $1'\twspanish\tspanish'
	;;
fy | fy_NL)
	echo $1'\twfrisian\tfrisian'
	;;
fo | fo_FO)
	echo $1'\twfaroese\tfaroese'
	;;
fr | fr_BE | fr_CA | fr_CH | fr_FR | fr_LU | fr_MC)
	echo $1'\twfrench\tfrench'
	;;
ga_IE)
	echo $1'\twirish\tirish'
	;;
gd | gd_GB)
	echo $1'\twgaelic\tgaelic'
	;;
gl | gl_ES)
	echo $1'\twgalician-minimos\tgalician-minimos'
	;;
gv | gv_GB)
	echo $1'\twmanx\tmanx'
	;;
#id | id_ID)
#	echo $1'\twindonesian\tindonesian'
#	;;
it | it_IT | it_CH)
	echo $1'\twitalian\titalian'
	;;
nl | nl_NL | nl_BE | nl_SR | nl_AN | nl_AW)
	echo $1'\twdutch\tdutch'
	;;
nb_NO)
	echo $1'\twnorwegian\tbokmaal'
	;;
nn_NO)
	#FIXME norsk -> /etc/dictionaries-common/norsk Is this correct? Not nynorsk?
	echo $1'\twnorwegian\tnynorsk'
	;;
pl | pl_PL)
	echo $1'\twpolish\tpolish'
	;;
pt_BR)
	echo $1'\twbrazilian\tbrazilian'
	;;
pt | pt_PT)
	echo $1'\twportuguese\tportuguese'
	;;
sv | sv_SE)
	echo $1'\twswedish\tswedish'
	;;
til)
	echo $1'\twtilburgs\ttilburgs'
	;;
tlh)
	echo $1'\twklingon\tklingon'
	;;
tlh_Latn)
	echo $1'\twklingon\tklingon-latin'
	;;
#tr | tr_TR)
#	echo $1'\twturkish\tturkish'
#	;;
uk | uk_UA)
	echo $1'\twukrainian\tukrainian'
	;;
*)
	echo 'ERROR: Unsupported language code '$1
	exit 1
	;;
esac
