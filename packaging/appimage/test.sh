dpkg -l docker.io | grep -q ^ii || exit "Docker not installed. run sudo apt install docker.io"
sudo appimage-builder --recipe 1804.yml --skip-script --skip-build --skip-appimage
