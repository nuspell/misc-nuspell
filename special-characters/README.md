# Supporting special characters

Sometimes words contain special characters. When these characters are not supported in the affix file, several things can go wrong. The result might be regarded is incorrect even though the word is in the dictionary. The word might be split in two words, which are both checked for spelling independently, but the result is reported on the separate words and the characters in which the split took place is omitted in the output. Stand-alone characters might also be omitted in the output even thoug thay are explicitely correct.

Examples of these words are:
* `km²`
* `H₂O`
* `HNO₃`
* `POP3`
* `H.265`
* `MP4`
* `UTF-8`
* `6th` English
* `R&D` English
* `south-Easterly` English (suggestion might be `South` for `south` when word is split)
* `C++` Dutch
* `Notepad++` Catalan
* `a.u.b.` Dutch
* `mms:` Swedish
* `km/h` Dutch
* `d'Azur` English
* `suppehøns's` Danish
* `Surname'` (when Surname ends with an `s`)
* `65+-kaart` Dutch (pass for people who are 65 years or over)
* `ochtend-` Dutch (in `ochtend- en avonddienst`)
* `-RNA` Dutch (in `primair-DNA en -RNA`)
* `poli(vinil-dehid)` Hungarian
* `*e*h*b*o` Basque (Euskera)
* `*pcmcia` Basque (Euskera)
* `p*h-adierazle` Basque (Euskera)

Typical special charactors that are often forgotten to be included in `WORDCHARS` in the affix file are:
* `0` `1` `2` `3` `4` `5` `6` `7` `8` `9` numerals
* `²` `³` `₂` `₃` superscript and subscript numerals
* `+` plus
* `.` period
* `-` hyphen
* `/` slash (should be escaped in the dictionary file)
* `:` colon
* `&` ampersand
* `*` asterisk
* `(` `)` brackets
* `_` underscore (often incorrect usage)
* `=` equals (often incorrect usage)
* `–` n-dash (often incorrect usage)

This directory contains tests to illustrate that certain special characters do need to be listed in `WORDCHARS` in an affix file.

**If the dictionary files and word list files you maintain contain spacial characters in words, please see the examples what the impact is and add the needed characters the proper affix files.**


Note that some files are symbolic links and other files are generated.

See also https://en.wikipedia.org/wiki/ISO/IEC_8859#Table

