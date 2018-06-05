# FreeBSD

## 1 Installation

Download an image from https://www.freebsd.org/where.html and install it. After booting, the default username is `freebsd` with the same as password. OF course, this is when you change your password with

    passwd

Then, become root with

    su - root

with again the username as password. Change that too with

    passwd

If you are on a Raspberry Pi 2, add to `/boot/msdos/config.txt` the line

    arm_freq=800

to overclock it. Execute the following to expand the file system:

    TODO

TODO something about maximum memory?

Reboot the system in order to get these changes into effect.

Update the system with

    freebsd-update fetch
    freebsd-update install

Install and udpate the package manager with

    pkg update
    pkg upgrade

then install the following package

    pkg install -y vim sudo tree

visudo
freebsd ALL=(ALL) ALL

    pkg install -y bash git autoconf automake libtool wget libiconv boost-libs icu gcc



.gitconfig

    mkdir workspace
    cd workspace
    git clone https://github.com/hunspell/nuspell.git
    cd nuspell




[freebsd@rpi2 ~/workspace/nuspell]$ pkg info -D boost_build

