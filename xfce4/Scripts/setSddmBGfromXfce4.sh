#!/bin/sh

# get current xfce4 wallpaper
currentBg=$(xfconf-query -c xfce4-desktop -lv | grep "workspace0/last-image" | sed 's/  */ /g' | cut -d" " -f2 | xargs realpath)
echo "The background path is $currentBg"
# Sddm conf file path
sddmConf="/etc/sddm.conf"
# Sddm current theme
themeFile="/usr/share/sddm/themes/$(grep ^Current $sddmConf | awk -F '=' '{ print $2}')/theme.conf"

echo "The theme path is $themeFile"

#TODO
# Get the themeFile line with the background option using Sed and
# and try to replace it with currentBg
pkexec sed -E -i "s#^Background=.+#Background=\"$currentBg\"#" $themeFile
