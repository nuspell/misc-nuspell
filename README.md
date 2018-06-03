# Misc Docs and Charts

This repository contains miscellaneous documentation, charts, tools and test scripts for Hunspell and, its successor, Nuspell.


## 1 Written documentation

* [Internal Specifications](internal-specs.html) ([Source](internal-specs.adoc))

## 2 Charts

Charts with documentation can be found in:

* [UML Diagrams](uml/README.md)
* [DFD](dfd/)


## 3 Tools

Tools for generating the docs:

1.  [Asciidoctor](http://asciidoctor.org/)
      - Install: `sudo apt install asciidoctor`
      - Use: `asciidoctor internal-specs.adoc`
2.  Project management tool: [RationalPlan
    Single](https://www.rationalplan.com/on-premise/#single)
      - Install by double clicking the .deb with Ubuntu software center
      - <https://wiki.mozilla.org/MOSS#Applicant.2FAwardee_Resources>
      - start `rationalplan-single &` and open
        `misc-hunspell/hunspell2-ratpln.srp`
      - remove lock file and other user preferences `rm -rf
        ~/.RationalPlan/ ~/.java/.userPrefs/RationalPlan`
3.  [PlantUML](http://plantuml.com/).
      - Install with: `sudo apt install plantuml`
      - If needed, manually upgrade `/usr/share/plantuml/plantuml.jar` to at least version 1.2018.1
4.  [Dataflow](https://github.com/sonyxperiadev/dataflow) for DFD.
      - Install: `sudo apt install cabal-install && cabal update &&
        cabal install dataflow`
      - Use: `~/.cabal/bin/dataflow`
5.  [Fabuala](http://drakon.su/programma_fabula_._redaktor_drakon-sxem)
      - Extranct manually then `wine fabula_0.1b_r001.exe`
6.  [Zippy git filter](https://bitbucket.org/sippey/zippey)

    After cloning or pulling run this only once to add the zippy filter:

        git config filter.zippey.smudge "$PWD/zippey.py d"
        git config filter.zippey.clean "$PWD/zippey.py e"
        rm $(git ls-files drakon)
        git checkout -- .


## 4 Testing

See the following README.md files on testing in the following order:
1. [1-support/README.md](1-support/README.md) on language support for Hunspell
2. [2-word-lists/README.md](2-word-lists/README.md) on word lists which can be used for testing
3. [3-checks/README.md](3-checks/README.md) on performance and regression testing
