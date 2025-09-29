#!/bin/sh
PATH_TO_THEMES=~/.config/alacritty/themes/alacrytheme/themes
OPTION=$(ls -1 $PATH_TO_THEMES | cut -d"." -f 1 | rofi -dmenu -p "Selecciona un tema")
if [ -n "$OPTION" ]; then
        sed --follow-symlinks -i -E "s/\w+-*\w*.toml/$OPTION\.toml/" ~/.config/alacritty/alacritty.toml
fi
