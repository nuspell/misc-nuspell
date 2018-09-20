#!/usr/bin/env sh

# description: converts recently changed PlantUML files into PNG and SVG files
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES

diagrams() {
	type=`echo $1|sed -e 's/\(.*\)/\L\1/'`
	if [ `find plantuml -name '*-'$type'-diagram.pu'|wc -l` -ne 0 ]; then
		if [ -e $type-diagrams ]; then
			# Delete SVG and PNG files which have no PlantUML source file
			cd $type-diagrams
			for i in *.svg; do
				source=`basename $i svg`pu
				if [ `find ../plantuml -name $source|wc -l` -eq 0 ]; then
					rm -f $i
				fi
			done
			for i in *.png; do
				source=`basename $i png`pu
				if [ `find ../plantuml -name $source|wc -l` -eq 0 ]; then
					rm -f $i
				fi
			done
			cd ..
		else
			mkdir $type-diagrams
		fi
		# Only generate if PlantUML file is new or is newer than output file
		for i in plantuml/*-$type-diagram.pu; do
			png=$type-diagrams/`basename $i pu`png
			if [ ! -e $png -o $i -nt $png ]; then
				echo 'Generating PNG for '$i'...'
				plantuml -tpng -o ../$type-diagrams $i
			fi
			svg=$type-diagrams/`basename $i pu`svg
			if [ ! -e $svg -o $i -nt $svg ]; then
				echo 'Generating SVG for '$i'...'
				plantuml -tsvg -o ../$type-diagrams $i
			fi
		done 
		echo '* [Nuspell - UML '$1' Diagrams]('$type'-diagrams/README.md)' >> README.md
		cd $type-diagrams
		echo '# Nuspell - UML '$1' Diagrams' > README.md
		for i in `ls *svg|sort`; do
		    echo '[![]('$i')]('$i')' >> README.md
		done
		cd ..
	fi
}

BASE='https://raw.githubusercontent.com/nuspell/misc-nuspell/master/uml'
echo '# Nuspell - UML Diagrams' > README.md
diagrams Usecase
diagrams Component
diagrams State
diagrams Activity
diagrams Object
diagrams Sequence
diagrams Class
# add Nuspell class diagram
if [ -e ../../nuspell/checks/hpp2plantuml.png ]; then
    cp -f ../../nuspell/checks/hpp2plantuml.png class-diagrams/nuspell.png
fi
if [ -e ../../nuspell/checks/hpp2plantuml.svg ]; then
    cp -f ../../nuspell/checks/hpp2plantuml.svg class-diagrams/nuspell.svg
    echo '[![](nuspell.svg)](nuspell.svg)' >> class-diagrams/README.md
fi
