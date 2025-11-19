#!/bin/bash

apply_theme () {
  #Check if the theme is already set, in every app or config
  CONFIG_DIR="$HOME/.config"
  theme_name=$1
  theme_variation=$2

  if [ -n "$2" ]; then
    theme_variation="-$2"
  fi

  # Change waybar theme, we do it first, cause hyprland will reload waybar config
  WAYBAR_CFG="$CONFIG_DIR/waybar/config"
  WAYBAR_STYLE="$CONFIG_DIR/waybar/style.css"
  WAYBAR_VAR_STYLE="$CONFIG_DIR/waybar/themes/$theme_name/style.css"
  WAYBAR_VAR_CFG="themes/$theme_name/config.jsonc"
  FULL_THEME_NAME="$theme_name$theme_variation.css"
  WAYBAR_THEME_NAME="themes/$theme_name/style.css"
  sed -E -i --follow-symlinks "s|(^@import\s+)(\")([^\"]+)(\")|\1\2$FULL_THEME_NAME\4|" "$WAYBAR_VAR_STYLE"
  sed -E -i --follow-symlinks "s|([\t ]+\"include\": +)(\[\")([^\"]+)(\"\])|\1\2$WAYBAR_VAR_CFG\4|" "$WAYBAR_CFG"
  sed -E -i --follow-symlinks "s|(^@import\s+)(\")([^\"]+)(\")|\1\2$WAYBAR_THEME_NAME\4|" "$WAYBAR_STYLE"

  # Change hyprland theme
  HYPR_CFG="$CONFIG_DIR/hypr/hyprland.conf"
  FULL_THEME_NAME="$theme_name$theme_variation.conf"
  sed -E -i --follow-symlinks "s|(^source.* +themes\/)(.*)|\1$FULL_THEME_NAME|" "$HYPR_CFG"

  # Alacritty theme
  ALA_CFG="$CONFIG_DIR/alacritty/alacritty.toml"
  FULL_THEME_NAME="themes/$theme_name$theme_variation.toml"
  sed -E -i --follow-symlinks "s|(^import.* )(\[\")([^\"]+)(\"\])|\1\2$FULL_THEME_NAME\4|" "$ALA_CFG"

  # Swaync theme
  SWAYNC_STYLE="$CONFIG_DIR/swaync/style.css"
  FULL_THEME_NAME="themes/$theme_name$theme_variation.css"
  sed -E -i --follow-symlinks "s|(^@import\s+)(\")([^\"]+)(\")|\1\2$FULL_THEME_NAME\4|" "$SWAYNC_STYLE"
  swaync-client -rs

  # Rofi theme
  ROFI_CFG="$CONFIG_DIR/rofi/config.rasi"
  FULL_THEME_NAME="themes/$theme_name$theme_variation.rasi"
  sed -E -i --follow-symlinks "s|(^@theme\s+)(\")([^\"]+)(\")|\1\2$FULL_THEME_NAME\4|" "$ROFI_CFG"
}

# TODO Probar tema rosepine en archivos reales
# se quitò las sequence de zsh
# se copio template de alacritty, probarla
THEME_OPTIONS="Catpuccine\nRosepine\nRosepine Moon\nRosepine Dawn\nWallust\nTokyonight\nNord\nEverforest"

SELECTED_OPTION=$(echo -e "$THEME_OPTIONS" | rofi -dmenu -i "Select a theme")
# use bash pattern substitution to get second word (moon, Dawn, empty)

if [ -z "$SELECTED_OPTION" ]; then
  exit
fi

read -r theme variation <<< "$SELECTED_OPTION"

apply_theme "${theme,,}" "${variation,,}"

