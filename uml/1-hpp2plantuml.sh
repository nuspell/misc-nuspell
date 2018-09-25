#!/usr/bin/env sh

# description: generates UML class diagram from header files
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# author: Sander van Geloven

cd plantuml

hpp2plantuml -i "../../../nuspell/src/nuspell/*.hxx" -o 99-source-generated-class-diagram.pu

#TODO https://github.com/thibaultmarin/hpp2plantuml/issues/4
#TODO https://github.com/thibaultmarin/hpp2plantuml/issues/5
sed -i -e 's/@startuml/# DO NOT EDIT, THIS FILE HAS BEEN GENERATED\n\n@startuml\n!include skin.iuml\n\ntitle Nuspell/' 99-source-generated-class-diagram.pu

cd ..
