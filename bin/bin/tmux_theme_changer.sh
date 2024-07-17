#!/bin/sh

PATH_TO_THEMES=~/.config/tmux/themes/
OPTION=$(ls -1 $PATH_TO_THEMES | cut -d"." -f 1 | rofi -dmenu -p "Selecciona un tema")
if [ -n "$OPTION" ]; then
	sed -i -E "s/\/\w+\.tmux/\/$OPTION\.tmux/" ~/.config/tmux/tmux.conf
	bash ~/.config/tmux/plugins/tpm/bin/install_plugins
	tmux source-file ~/.config/tmux/tmux.conf
fi
