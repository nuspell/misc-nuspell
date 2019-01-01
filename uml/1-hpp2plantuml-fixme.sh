#!/usr/bin/env sh

# description: generates UML class diagram from header files
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# author: Sander van Geloven

cd plantuml

hpp2plantuml -i "../../../nuspell/src/nuspell/*.hxx" -o 99-source-generated-class-diagram.pu -t 99-source-generated-class-diagram.jinja

cd ..
