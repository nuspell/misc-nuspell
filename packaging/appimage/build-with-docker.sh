sudo docker build . -t nuspell-appimage
sudo docker container rm nuspell-appimage-container
APPIMAGE_NAME=`sudo docker run --name=nuspell-appimage-container nuspell-appimage sh -c "cd out && echo Nuspell*.AppImage"`
sudo docker cp nuspell-appimage-container:"/root/out/$APPIMAGE_NAME" .
sudo chown "$USER:" "$APPIMAGE_NAME"
