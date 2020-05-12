# GtkSourceView syntax highlighting

GtkSourceView syntax highlighting supports many file formats and is used in editors such as [gedit](https://en.wikipedia.org/wiki/Gedit). Here the file [aff.lang](aff.lang) is found that supports the affix file format.

Install this file by copying it to `/usr/share/gtksourceview-3.0/language-specs/`.

See the resulting syntax highlighting with:

    gedit /usr/share/hunspell/*.aff

Note: at the moment, this syntax highlighting is still in development.

See also the syntax highlighting for [Vim](https://en.wikipedia.org/wiki/Vim_%28text_editor%29) in [../vim-syntax/README.md](../vim-syntax/README.md)

![Screenshot](screenshot.png?raw=true)
