#!/bin/bash

killall -q waybar

while pgrep -x waybar >/dev/null; do sleep 1; done

theme=$1

if [ -z "$theme" ]; then
	waybar
else
	waybar -c "$HOME/.config/waybar/themes/$theme/config.jsonc" -s "$HOME/.config/waybar/themes/$theme/style.css"
fi
