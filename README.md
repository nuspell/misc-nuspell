# Misc Docs and Charts

This repository contains miscellaneous documentation, charts, tools and test
scripts for Hunspell and, its successor, Nuspell.


## 1 Written documentation

* [Annotated source code](code-comments/) in FODT files in the top-level
  directory. These cannot be viewed in GitHub or a browser and need LibreOffice
  for proper viewing.

## 2 Charts

Charts with documentation can be found in:

* [UML Diagrams](uml/README.md)
* [DFD](dfd/)


## 3 Tools

Tools for generating the docs:

1.  [Asciidoctor](http://asciidoctor.org/)
      - Install: `sudo apt install asciidoctor`
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
4.  [Dataflow](https://github.com/sonyxperiadev/dataflow) for DFD.
      - Install: `sudo apt install cabal-install && cabal update &&
        cabal install dataflow`
      - Use: `~/.cabal/bin/dataflow`


## 4 Testing

See the following README.md files on testing in the following order:
1. [1-support/README.md](1-support/README.md) on language support for Hunspell
2. [2-word-lists/README.md](2-word-lists/README.md) on word lists which can be used for testing
3. [3-checks/README.md](3-checks/README.md) on performance and regression testing

All shells scripts run at least in sh, bash, ksh and zsh.
