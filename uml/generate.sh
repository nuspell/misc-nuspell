function diagrams() {
	type=`echo $1|sed -e 's/\(.*\)/\L\1/'`
	if [ `find plantuml -name '*-'$type'-diagram.pu'|wc -l` -ne 0 ]; then
		if [ -e $type-diagrams ]; then
			# Delete SVG files which have no PlantUML source file
			cd $type-diagrams
			for i in *.svg; do
				source=`basename $i svg`pu
				if [ `find ../plantuml -name $source|wc -l` -eq 0 ]; then
					rm -f $i
				fi
			done
			cd ..
		else
			mkdir $type-diagrams
		fi
		# Only generate if PlantUML file is new or is newer than SVG file
		for i in plantuml/*-$type-diagram.pu; do
			png=$type-diagrams/`basename $i pu`png
			if [ $i -nt $png ]; then
				echo 'Processing '$i'...'
				plantuml -tpng -o ../$type-diagrams $i
			fi
			svg=$type-diagrams/`basename $i pu`svg
			if [ $i -nt $svg ]; then
				echo 'Processing '$i'...'
				plantuml -tsvg -o ../$type-diagrams $i
			fi
		done 
		echo '* [Hunspell - UML '$1' Diagrams]('$type'-diagrams/README.md)' >> README.md
		cd $type-diagrams
		echo '# Hunspell - UML '$1' Diagrams' > README.md
		for i in *svg
		do
		    echo '[![]('$i')]('$i')' >> README.md
		done
		cd ..
	fi
}

BASE='https://raw.githubusercontent.com/hunspell/misc-hunspell/master/uml'
echo '# Hunspell - UML Diagrams' > README.md
diagrams Usecase
diagrams Component
diagrams State
diagrams Activity
diagrams Object
diagrams Class
diagrams Sequence
