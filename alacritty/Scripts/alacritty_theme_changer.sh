#!/bin/sh
THEME_PATH=themes/alacrytheme/themes
ABS_THEME_PATH=~/.config/alacritty/$THEME_PATH

OPTION=$(find $ABS_THEME_PATH -type f,l -exec basename {} \; | cut -d"." -f 1 | rofi -dmenu -p "Selecciona un tema")
if [ -n "$OPTION" ]; then
        sed --follow-symlinks -i -E "s|(^import.* )(\[\")(.+)(\.toml\"\])|\1\2$THEME_PATH\/$OPTION\4|" ~/.config/alacritty/alacritty.toml
fi
