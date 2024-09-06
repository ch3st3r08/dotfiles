#!/usr/bin/sh

wallpaperConfig="$HOME/.config/waypaper/config.ini"
newWallpaperPath=$(grep ^wallpaper $wallpaperConfig | awk '{print $3}' | xargs realpath)
linkTarget="/opt/wallpapers/background"

ln -sf $newWallpaperPath $linkTarget
