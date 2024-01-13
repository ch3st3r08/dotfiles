#!/bin/bash

if [[ $(id -u) -ne 0 ]]; then
   error "Se necesitan privilegios administrativos"
   exit 1
fi

#Testear si existe y si no crear la carpeta
DEST_PATH=/usr/share/backgrounds/display-manager-bg
USER_PATH="/home/$SUDO_USER"

IMG_PATH=$(cat $USER_PATH/.config/nitrogen/bg-saved.cfg | grep file | cut -d'=' -f2)

#We don't need to extract the extension anymore
#imgExt=${IMG_PATH##*.}
#BG_PATH="$DEST_PATh/background.$imgExt"

BG_PATH="$DEST_PATH/background"
cp $IMG_PATH $BG_PATH
