#!/usr/bin/env sh

SHORT=2.2
LONG=$SHORT.0
PATCH=0
ORIG='nuspell_'$LONG'.orig.tar.gz'

echo 'SHORT: '$SHORT
echo 'LONG:  '$LONG
echo 'PATCH: '$PATCH

replace() {
	sed -i -e 's/LONG/'$LONG'/g' $FILE
	sed -i -e 's/SHORT/'$SHORT'/g' $FILE
	sed -i -e 's/PATCH/'$PATCH'/g' $FILE
}

sums() {
	ORGFILE='nuspell_'$LONG'.orig.tar.gz'
	DEBFILE='nuspell_'$LONG'-'$PATCH'.debian.tar.xz'

	ORGSIZE=`ls -l $ORGFILE|awk '{print $5}'`
	DEBSIZE=`ls -l $DEBFILE|awk '{print $5}'`
	ORGSHA1=`sha1sum $ORGFILE|awk '{print $1}'`
	DEBSHA1=`sha1sum $DEBFILE|awk '{print $1}'`
	ORGSHA256=`sha256sum $ORGFILE|awk '{print $1}'`
	DEBSHA256=`sha256sum $DEBFILE|awk '{print $1}'`
	ORGMD5=`md5sum $ORGFILE|awk '{print $1}'`
	DEBMD5=`md5sum $DEBFILE|awk '{print $1}'`

	sed -i -e 's/ORGFILE/'$ORGFILE'/g' $FILE
	sed -i -e 's/DEBFILE/'$DEBFILE'/g' $FILE
	sed -i -e 's/ORGSIZE/'$ORGSIZE'/g' $FILE
	sed -i -e 's/DEBSIZE/'$DEBSIZE'/g' $FILE
	sed -i -e 's/ORGSHA1/'$ORGSHA1'/g' $FILE
	sed -i -e 's/DEBSHA1/'$DEBSHA1'/g' $FILE
	sed -i -e 's/ORGSHA256/'$ORGSHA256'/g' $FILE
	sed -i -e 's/DEBSHA256/'$DEBSHA256'/g' $FILE
	sed -i -e 's/ORGMD5/'$ORGMD5'/g' $FILE
	sed -i -e 's/DEBMD5/'$DEBMD5'/g' $FILE
}

wget -q 'https://github.com/nuspell/nuspell/archive/v'$LONG'.tar.gz' -O $ORIG

rm -rf debian
cp -a debian.template debian
cd debian

FILE=control
replace

FILE=rules
replace

FILE=libnuspell-SHORT-PATCH.shlibs
replace
mv -f libnuspell-SHORT-PATCH.shlibs 'libnuspell-'$SHORT'-'$PATCH'.shlibs'

mv -f libnuspell-SHORT-PATCH.install 'libnuspell-'$SHORT'-'$PATCH'.install'

tar xf ../$ORIG 'nuspell-'$LONG'/LICENSES'
mv 'nuspell-'$LONG'/LICENSES' copyright

rmdir 'nuspell-'$LONG
cd ..

tar cfJ 'nuspell_'$LONG'-'$PATCH'.debian.tar.xz' debian

FILE='nuspell_'$LONG'-'$PATCH'.dsc'
cp nuspell_LONG-PATCH.dsc.template $FILE
replace
sums
