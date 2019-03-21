SHORT=2.2
LONG=$SHORT.0
PATCH=0
ORIG='nuspell_'$LONG'.orig.tar.gz'

echo 'SHORT: '$SHORT
echo 'LONG:  '$LONG
echo 'PATCH: '$PATCH

function search-and-replace {
	sed -i -e 's/LONG/'$LONG'/g' $FILE
	sed -i -e 's/SHORT/'$SHORT'/g' $FILE
	sed -i -e 's/PATCH/'$PATCH'/g' $FILE
}

wget -q 'https://github.com/nuspell/nuspell/archive/v'$LONG'.tar.gz' -O $ORIG

rm -rf debian
cp -a debian.template debian
cd debian

FILE=control
search-and-replace

FILE=rules
search-and-replace

FILE=libnuspell-SHORT-PATCH.shlibs
search-and-replace
mv -f libnuspell-SHORT-PATCH.shlibs 'libnuspell-'$SHORT'-'$PATCH'.shlibs'

mv -f libnuspell-SHORT-PATCH.install 'libnuspell-'$SHORT'-'$PATCH'.install'

tar xvf ../$ORIG 'nuspell-'$LONG'/LICENSES'
mv 'nuspell-'$LONG'/LICENSES' copyright

tar xvf ../$ORIG 'nuspell-'$LONG'/CHANGELOG.md'
mv 'nuspell-'$LONG'/CHANGELOG.md' changelog

rmdir 'nuspell-'$LONG
cd ..

tar cfJ 'nuspell_'$LONG'-'$PATCH'.debian.tar.xz' debian
