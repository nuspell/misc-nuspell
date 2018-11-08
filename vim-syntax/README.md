# Vim syntax highlighting

[Vim](https://en.wikipedia.org/wiki/Vim_%28text_editor%29) syntax highlighting supports any file formats. Here the file [aff.vim](aff.vim) is found that supports the affix file format.

Install this file by copying it to `/usr/share/vim/vim80/syntax/`.

Add to `/usr/share/vim/vim80/syntax/filetype.vim` the lines before the part on `" Avenue`:

    " Affix file for Nuspell and Hunspell
    :au BufNewFile,BufRead *.aff			setf aff

Also add to `/usr/share/vim/vim80/syntax/sysmenu.vim` the line before the line with `an 50.10.180`:

    an 50.10.175 &Syntax.AB.Affix :cal SetSyn("aff")<CR>

See the resulting syntax highlighting with:

    vim /usr/share/hunspell/*.aff

Note: at the moment, this syntax highlighting is still in development.

See also the syntax highlighting for [gedit](https://en.wikipedia.org/wiki/Gedit) via GtkSourceView in [../gtksourceview/README.md](../gtksourceview/README.md)

![Screenshot](screenshot.png?raw=true)
