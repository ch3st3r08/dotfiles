#!/bin/bash

line1="Lock\0icon\x1f<span></span>"
line2="Logout\0icon\x1f<span>󰍃</span>"
line3="Reboot\0icon\x1f<span>󰜉</span>"
line4="Shutdown\0icon\x1f<span>⏻ </span>"

choice=$(printf "$line1\n$line2\n$line3\n$line4" | rofi -dmenu -i -l 1 \
-theme-str 'window { border:0;width: 500px;}' \
-theme-str 'listview { columns: 4; spacing: 5px; border:0;}' \
-theme-str 'element { height:100px; orientation:vertical;}' \
-theme-str 'element selected.normal{ border: 0; text-color:white; background-color:rgba(200,200,200,0.2);}' \
-theme-str 'element.normal.normal { border: 0; text-color:white;}' \
-theme-str 'element.alternate.normal { border: 0; text-color:white;}' \
-theme-str 'inputbar { enabled: false; }' \
-theme-str 'element-text {horizontal-align:0.5;highlight: underline red; text-color:inherit;}' \
-theme-str 'element-icon { size: 4.0em; text-color:yellow;}' \
-theme-str 'element-icon span { text-color:inherit;}' \
-hover-select true \
-me-select-entry 'MousePrimary' \
-me-accept-entry '!MousePrimary')
echo "$choice"
case "$choice" in
    "Shutdown")  systemctl -i poweroff
      ;;
    "Reboot")  systemctl reboot
      ;;
    "Logout")  loginctl terminate-session $XDG_SESSION_ID
      ;;        # or: loginctl terminate-session $XDG_SESSION_ID
    "Lock")    loginctl lock-session
      ;;        # or: loginctl terminate-session $XDG_SESSION_ID
esac
