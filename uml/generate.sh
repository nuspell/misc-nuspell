#!/usr/bin/env bash

function diagrams() {
	type=`echo $1|sed -e 's/\(.*\)/\L\1/'`
	if [ `find plantuml -name '*-'$type'-diagram.pu'|wc -l` -ne 0 ]; then
		if [ -e $type-diagrams ]; then
			rm -f $type-diagrams/*.svg
		else
			mkdir $type-diagrams
		fi
		plantuml -tsvg -o ../$type-diagrams plantuml/*-$type-diagram.pu
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
diagrams State
diagrams Activity
diagrams Object
diagrams Class
