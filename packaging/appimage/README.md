# AppImage

Get the latest version of `pkg2appimage` with:

    wget https://github.com/AppImage/pkg2appimage/archive/master.zip
    unzip master.zip

Make sure that `nuspell.yml`refers twice to the latest Ubuntu LTS release.

Then, an AppImage will be created in the `out` directory by running:

    pkg2appimage-master/pkg2appimage nuspell.yml

It can be tested with e.g.:

    ./out/Nuspell-.glibc2.3.3-x86_64.AppImage -D

and

    echo hallo | ./out/Nuspell-.glibc2.3.3-x86_64.AppImage -d /usr/share/hunspell/nl

Note that the AppImage is using dictionaries installed on the system it runs.
