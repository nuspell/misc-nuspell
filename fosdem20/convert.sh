#!/usr/bin/env sh

cd images
for i in *svg; do
	inkscape -D -z --file=$i --export-pdf=`basename $i svg`pdf --export-latex
done
#mv -f *.pdf *.pdf_tex ..
cd ..
