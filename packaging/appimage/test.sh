cd "$(dirname "$0")"
dpkg -l docker.io | grep -q ^ii || exit "Docker not installed. run sudo apt install docker.io"
sudo appimage-builder --skip-script --skip-build --skip-appimage #--recipe AppImageBuilder.yml
