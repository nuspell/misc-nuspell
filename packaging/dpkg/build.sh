rm -rf nuspell-3.0.0
tar xf nuspell_3.0.0.orig.tar.gz
cp -a debian nuspell-3.0.0
cd nuspell-3.0.0
dpkg-buildpackage
