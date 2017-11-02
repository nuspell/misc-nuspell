BASE='https://raw.githubusercontent.com/hunspell/misc-hunspell/master/uml'

echo '# Hunspell - UML Diagrams' > README.md

if [ `ls plantuml/*-state-diagram.pu|wc -l` -ne 0 ]; then
	rm -f ../state-diagrams/*.svg
	plantuml -tsvg -o ../state-diagrams plantuml/*-state-diagram.pu
	echo '* [Hunspell - UML State Diagrams](state-diagrams/README.md)' >> README.md
	cd state-diagrams
	echo '# Hunspell - UML State Diagrams' > README.md
	for i in *svg
	do
	    echo '[![]('$i'?raw=true)]('$BASE'/state-diagrams/'$i')' >> README.md
	done
	cd ..
fi

if [ `ls plantuml/*-usecase-diagram.pu|wc -l` -ne 0 ]; then
	rm -f ../usecase-diagrams/*.svg
	plantuml -tsvg -o ../usecase-diagrams plantuml/*-usecase-diagram.pu
	echo '* [Hunspell - UML Usecase Diagrams](usecase-diagrams/README.md)' >> README.md
	cd usecase-diagrams
	echo '# Hunspell - Hunspell - UML Usecase Diagrams' > README.md
	for i in *svg
	do
	    echo '[![]('$i'?raw=true)]('$BASE'/usecase-diagrams/'$i')' >> README.md
	done
	cd ..
fi

if [ `ls plantuml/*-object-diagram.pu|wc -l` -ne 0 ]; then
	rm -f ../object-diagrams/*.svg
	plantuml -tsvg -o ../object-diagrams plantuml/*-object-diagram.pu
	echo '* [Hunspell - UML Object Diagrams](object-diagrams/README.md)' >> README.md
	cd object-diagrams
	echo '# Hunspell - Hunspell - UML Object Diagrams' > README.md
	for i in *svg
	do
	    echo '[![]('$i'?raw=true)]('$BASE'/object-diagrams/'$i')' >> README.md
	done
	cd ..
fi

if [ `ls plantuml/*-class-diagram.pu|wc -l` -ne 0 ]; then
	rm -f ../class-diagrams/*.svg
	plantuml -tsvg -o ../class-diagrams plantuml/*-class-diagram.pu
	echo '* [Hunspell - UML Class Diagrams](class-diagrams/README.md)' >> README.md
	cd class-diagrams
	echo '# Hunspell - Hunspell - UML Class Diagrams' > README.md
	for i in *svg
	do
	    echo '[![]('$i'?raw=true)]('$BASE'/class-diagrams/'$i')' >> README.md
	done
	cd ..
fi
