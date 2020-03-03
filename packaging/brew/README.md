_This might move to the wiki._

# Homebrew

The Formula for Nuspell is in `nuspell.rb`. This currently resides in
the following [tap](https://docs.brew.sh/Taps)
https://github.com/nuspell/homebrew-nuspell

Note that the `:dunno` is to allow building in Linuxbrew. Works only when it
is at the end.


## Linux

To develop on Linux, do the following.

    apt-get install linuxbrew-wrapper
    brew
    cd $(brew --repository homebrew/core)
    cd ..
    rm -rf homebrew-core
    git clone https://github.com/Homebrew/linuxbrew-core
    mv linuxbrew-core homebrew-core
    cd


## Installing

This tap in installed by

    brew tap nuspell/nuspell

This will make the tap available under `/home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/nuspell/homebrew-nuspell/`. In there is also `Formula/nuspell.rb`.

To update a tap, run

    brew update


## Development

Make changes to `nuspell.rb` if needed. Check it with

    brew audit --strict nuspell

If upstream has also a Nuspell formula, refer to the one from the tap
explicitely

    brew audit --strict nuspell/nuspell/nuspell

Build and test it with

    brew reinstall -v -s nuspell && brew test -v nuspell

or explicitely from the tap

    brew reinstall -v -s nuspell/nuspell/nuspell && brew test -v nuspell/nuspell/nuspell


## Upstream

Ask upstream homebrew-core to include formula for Nuspell when Nuspell is
[notable enough](https://github.com/Homebrew/homebrew-core/pull/50685#issuecomment-591614333).
When that has been done, linuxbrew-core can also be [asked](https://github.com/Homebrew/linuxbrew-core/pull/19714#issuecomment-590907806)
to support the formula for Nuspell.
