set -e # -e for automatic error handling
# if we need newer cmake https://apt.kitware.com/
# if we need newer GCC https://launchpad.net/~ubuntu-toolchain-r/+archive/ubuntu/test
# The command add-apt-repository is part of the package software-properties-common
apt-get update
apt-get install -y wget g++-8 make cmake libicu-dev
