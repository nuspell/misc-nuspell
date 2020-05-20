[Packaging Nuspell](https://github.com/nuspell/nuspell/wiki/Nuspell-packaged-binaries)
requires specific types of descriptions. To facilitate this, here are ready-made
descriptions of Nuspell. Please, contact us if you see something is missing.

### Name

The name of Nuspell is...

    Nuspell

Do not use `nuspell` or `NuSpell`.

### Preferred descriptions

<!--Short description for an end-user is:

    spellchecking library and command-line tool-->

Short description <!--for a developer--> is ([source](https://github.com/nuspell/nuspell)):

    Fast and safe spellchecking C++ library

Do not use `spelling checking library` or `spell checker`.

Long description in MarkDown is ([source](https://github.com/nuspell/nuspell/blob/master/README.md)):

    Nuspell is a fast and safe spelling checker software program. It is designed
    for languages with rich morphology and complex word compounding.
    Nuspell is written in modern C++ and it supports Hunspell dictionaries.
    
    Main features of Nuspell spelling checker:
    
      - Provides software library and command-line tool.
      - Suggests high-quality spelling corrections.
      - Backward compatibility with Hunspell dictionary file format.
      - Up to 3 times faster than Hunspell.
      - Full Unicode support backed by ICU.
      - Twofold affix stripping (for agglutinative languages, like Azeri,
        Basque, Estonian, Finnish, Hungarian, Turkish, etc.).
      - Supports complex compounds (for example, Hungarian, German and Dutch).
      - Supports advanced features, for example: special casing rules
        (Turkish dotted i or German sharp s), conditional affixes, circumfixes,
        fogemorphemes, forbidden words, pseudoroots and homonyms.
      - Free and open source software. Licensed under GNU LGPL v3 or later.

In HTML, it is ([source](https://github.com/nuspell/misc-nuspell/blob/master/packaging/appstream/org.nuspell.Nuspell.metainfo.xml)):

    <p>Nuspell is a fast and safe spelling checker software program. It is designed for languages with rich morphology and complex word compounding. Nuspell is written in modern C++ and it supports Hunspell dictionaries.</p>
    <p>Main features of Nuspell spelling checker:</p>
    <ul>
        <li>Provides software library and command-line tool.</li>
        <li>Suggests high-quality spelling corrections.</li>
        <li>Backward compatibility with Hunspell dictionary file format.</li>
        <li>Up to 3 times faster than Hunspell. - Full Unicode support backed by ICU.</li>
        <li>Twofold affix stripping (for agglutinative languages, like Azeri, Basque, Estonian, Finnish, Hungarian, Turkish, etc.).</li>
        <li>Supports complex compounds (for example, Hungarian, German and Dutch).</li>
        <li>Supports advanced features, for example: special casing rules (Turkish dotted i or German sharp s), conditional affixes, circumfixes, fogemorphemes, forbidden words, pseudoroots and homonyms.</li>
        <li>Free and open source software. Licensed under GNU LGPL v3 or later.</li>
    </ul>

Please, do not write that Nuspell is a replacement of Hunspell.

### Alternative descriptions

An ultrashort description (but not preferred) is:

  spellchecker

A long description of only one paragraph is simply the first paragraph of the long description ([source](https://github.com/nuspell/nuspell/blob/master/README.md)):

    Nuspell is a fast and safe spelling checker software program. It is designed
    for languages with rich morphology and complex word compounding. Nuspell is
    written in modern C++ and it supports Hunspell dictionaries.

### Keywords

The following are preferred keywords ([source](https://github.com/nuspell/misc-nuspell/blob/master/packaging/appstream/org.nuspell.Nuspell.metainfo.xml)):
* spelling checker
* spelling corrector
* spellcheck
* spellchecker
* spellchecking

The following are keywords are not preferred:
* spell checker

### Parts

For packaging, Nuspell consists of ([source](https://github.com/nuspell/misc-nuspell/blob/master/packaging/deb/debian/control)):
* spellchecking shared library
* spellchecking program
* spellchecking development

### Special

For file names, directories, etc. use:

    nuspell

In case a reverse order domain name is needed, use ([source](https://github.com/nuspell/misc-nuspell/blob/master/packaging/appstream/org.nuspell.Nuspell.metainfo.xml)):

    org.nuspell.Nuspell

### Colors

For moment, use only black on white for text on background.

### Images

The Nuspell logo on transparent background is:

https://github.com/nuspell/nuspell.github.io/blob/master/assets/images/logo-trans.svg

and with white background is:

https://github.com/nuspell/nuspell.github.io/blob/master/assets/images/logo-white.svg

When the logo is to be cut out in a circle, please use:

https://github.com/nuspell/nuspell.github.io/blob/master/assets/images/logo-for-circle-trans.svg

or:

https://github.com/nuspell/nuspell.github.io/blob/master/assets/images/logo-for-circle-white.svg

These files are also available as 512 x 512 pixels optimized PNG in:
* https://github.com/nuspell/nuspell.github.io/blob/master/assets/images/logo-trans-512x512.png
* https://github.com/nuspell/nuspell.github.io/blob/master/assets/images/logo-white-512x512.png
* https://github.com/nuspell/nuspell.github.io/blob/master/assets/images/logo-for-circle-trans-512x512.png
* https://github.com/nuspell/nuspell.github.io/blob/master/assets/images/logo-for-circle-white-512x512.png
