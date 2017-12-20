# Misc Docs and Charts

## Docs

  - [Internal Specs](internal-specs.html)
    ([Source](internal-specs.adoc))

## Charts

  - [UML](uml/)
  - [DFD](dfd/)

## Tools

Tools for generating the docs:

1.  [Asciidoctor](http://asciidoctor.org/)

      - Install: `sudo apt install asciidoctor`
      - Use: `asciidoctor internal-specs.adoc`

2.  Project management tool: [RationalPlan
    Single](https://www.rationalplan.com/on-premise/#single)

      - Install by double clicking the .deb with Ubuntu software center
      - https://wiki.mozilla.org/MOSS\#Applicant.2FAwardee\_Resources
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

5.  [Fabuala](http://drakon.su/programma_fabula_._redaktor_drakon-sxem)

      - Extranct manually then `wine fabula_0.1b_r001.exe`

6.  [Zippy git filter](https://bitbucket.org/sippey/zippey)

    After cloning or pulling run this only once to add the zippy filter:

        git config filter.zippey.smudge "$PWD/zippey.py d"
        git config filter.zippey.clean "$PWD/zippey.py e"
        rm $(git ls-files drakon)
        git checkout -- .
