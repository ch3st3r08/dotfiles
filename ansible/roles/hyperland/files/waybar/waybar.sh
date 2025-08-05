#!/bin/bash

killall -q waybar

while pgrep -x waybar >/dev/null; do sleep 1; done

theme=$1
style_dir=$HOME/.config/waybar/themes/$theme
if [ -z "$theme" ]; then
    waybar
else
    waybar -c "$style_dir/config.jsonc" -s "$style_dir/style.css"
fi
