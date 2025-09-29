#!/bin/zsh

# get current waypaper wallpaper
currentBgPath=$HOME/.config/waypaper/config.ini
raw_path=$(awk -F'[ =]+' '/wallpaper/ {print $2}' $currentBgPath)
# Replace tilde with user path, because Tilde expansion
currentBg="${raw_path/#\~/$HOME}"
currentBg=$(realpath "$currentBg")
echo "El path es $currentBg"
#Sddm conf file path
sddmConf="/etc/sddm.conf"
# Sddm current theme
themeFile="/usr/share/sddm/themes/$(grep ^Current $sddmConf | awk -F '=' '{ print $2}')/theme.conf"

echo "The theme path is $themeFile"

#TODO
# Get the themeFile line with the background option using Sed and
# and try to replace it with currentBg
pkexec sed -E -i "s#^Background=.+#Background=\"$currentBg\"#" $themeFile
