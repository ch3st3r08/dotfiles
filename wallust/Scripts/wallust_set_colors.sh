#!/bin/env bash

currentBgPath=$HOME/.config/waypaper/config.ini
raw_path=$(awk -F'[ =]+' '/wallpaper/ {print $2}' $currentBgPath)
# Replace tilde with user path, because Tilde expansion
currentBg="${raw_path/#\~/$HOME}"
# wallust -T -s run "$currentBg"
wallust -s run "$currentBg"
sleep 1
swaync-client -rs
