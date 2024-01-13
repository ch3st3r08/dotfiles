#!/bin/sh
PATH_TO_THEMES=~/.config/alacritty/themes/themes/themes
OPTION=$(ls -1 $PATH_TO_THEMES | cut -d"." -f 1 | rofi -dmenu -p "Selecciona un tema")
if [ -n "$OPTION" ]; then
	sed -i -E "s/\w+-*\w*.toml/$OPTION\.toml/" ~/.config/alacritty/alacritty.toml
fi
