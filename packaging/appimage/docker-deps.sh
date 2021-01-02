set -e # -e for automatic error handling
apt-get update
apt-get install -y apt-transport-https ca-certificates gnupg software-properties-common wget
add-apt-repository -y ppa:ubuntu-toolchain-r/test
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
apt-add-repository -y 'deb https://apt.kitware.com/ubuntu/ xenial main'
apt-get update
apt-get install -y build-essential g++-7 cmake libicu-dev
