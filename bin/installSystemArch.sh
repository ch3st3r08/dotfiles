#!/bin/bash

_DEBUG=0
IS_VM=0

while getopts 'hvd' OPTION; do
  case "$OPTION" in
    h)
      echo "Usage: $0 [-h] [-v]"
      ;;
    v)
      IS_VM=1
      ;;
    d)
      _DEBUG=1
      ;;
    *)
      echo "Usage: $0 [-h] [-v]" >&2
      exit 1
      ;;
  esac
done

shift "$(($OPTIND -1))"

error() {
  printf '\E[31m'; echo "$@"; printf '\E[0m'
}

info() {
  printf '\E[32m'; echo "$@"; printf '\E[0m'
}

warn(){
  printf '\E[33m'; echo "$@"; printf '\E[0m'
}

ask() {
  local continuar
  warn "Desea continuar con el siguiente paso (y/n)?: "
  read continuar
  if [[ ! $continuar = "y" ]]; then
    exit 1
  fi
}

#Descargar e instalar Paru (AUR helper)
git clone https://aur.archlinux.org/paru.git Sources/paru
cd Sources/paru
makepkg -si

cd $HOME

echo "---------------------------------------------------------------"
info "Instalando archivos necesarios"
paru -S base-devel curl libsecret pacman-contrib xorg i3 polybar picom network-manager-applet zsh tmux gvfs gvfs-smb thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman xarchiver rofi pulseaudio pulseaudio-alsa polkit-gnome xfce4-power-manager lightdm lightdm-gtk-greeter-settings light-locker light-locker-settings dunst dex desktop-file-utils xdg-utils xdg-user-dirs htop neofetch neovim starship alacritty community/exa community/ripgrep bat fd unzip seahorse mugshot grub-customizer ffmpeg mpv pavucontrol brave-browser gtk-engine-murrine lxappearance mpd ncmpcpp flameshot nitrogen xclip xpad font-manager seahorse feh zathura zathura-pdf-mupdf ttf-hack-nerd ttf-iosevka-nerd ttf-firacode-nerd ttf-sourcecodepro-nerd ttf-terminus-nerd plymouth-theme-arch10


echo "---------------------------------------------------------------"
info "Instalando #-NVM (node version manager)"
export NVM_DIR="$HOME/.nvm"
git clone https://github.com/nvm-sh/nvm.git $NVM_DIR
cd $NVM_DIR
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
cd $HOME


info "Creando directorio de themes e íconos"
mkdir -p $HOME/.local/share/themes
mkdir -p $HOME/.local/share/icons

info "Instalando tema Nord, Nord Icon y Nord Cursor de forma Global"
git clone https://github.com/EliverLara/Nordic Sources/Nordic_theme
git clone https://github.com/robertovernina/NordArc Sources/NordArc_icon_theme
git clone https://github.com/alvatip/Nordzy-cursors Sources/Nordzy-cursors
sudo cp -R Sources/Nordic_theme /usr/share/themes/Nordic
sudo cp -R Sources/NordArc_icon_theme/NordArc-Icons /usr/share/icons
sudo cp -R Sources/Nordzy-cursors/Nordzy-cursors /usr/share/icons
sudo cp -R Sources/Nordzy-cursors/Nordzy-cursors-white /usr/share/icons

info "Configurando propiedades default del lightdm-gtk-greeter-settings"
sudo tee -a <<'EOF' /etc/lightdm/lightdm-gtk-greeter.conf >/dev/null
[greeter]
background = /usr/share/backgrounds/display-manager-bg/background
theme-name = Nordic
icon-theme-name = NordArc-icons
EOF

info "Creando carpeta display-manager-bg en /usr/share/backgrounds"
sudo install -d /usr/share/backgrounds/display-manager-bg
sudo cp -v Sources/background/default_wallpaper.png /usr/share/backgrounds/display-manager-bg/background

info "Creando archivo bg-saved.cfg"
NITRO_PATH=$HOME/.config/nitrogen

mkdir -p $NITRO_PATH
cat <<EOF >> $NITRO_PATH/bg-saved.cfg
[xin_-1]
file=$HOME/Sources/background/default_wallpaper.png
mode=0
bgcolor=#000000
EOF

info "Descargando tema de grub en Downloads"
curl -Lo Downloads/arch.tar https://github.com/AdisonCavani/distro-grub-themes/releases/latest/download/arch.tar

info "Iniciando servicios de lightdm"
sudo systemctl enable --now lightdm

info "La instalacion del sistema ha terminado, se recomienda REINICIAR el sistema, para que los cambios surjan efecto."
