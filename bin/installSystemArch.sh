#!/bin/bash

_DEBUG=0
IS_VM=0
WM="xfce4"

#Descargar e instalar Paru (AUR helper)
git clone https://aur.archlinux.org/paru.git Sources/paru
cd Sources/paru
makepkg -si

cd $HOME

echo "---------------------------------------------------------------"
echo "Instalando archivos necesarios"
paru -S base-devel curl libsecret pacman-contrib xorg network-manager-applet zsh tmux gvfs gvfs-smb gvfs-nfs pipewire pipewire-audio pipewire-pulse wireplumber lightdm lightdm-gtk-greeter-settings light-locker light-locker-settings xdg-utils xdg-user-dirs neofetch neovim starship alacritty unzip mpv pavucontrol brave-browser gtk-engine-murrine mpd ncmpcpp ttf-hack-nerd ttf-iosevka-nerd ttf-firacode-nerd ttf-sourcecodepro-nerd ttf-terminus-nerd plymouth plymouth-theme-arch10


if [ $WM == "i3" ]; then
	paru -S i3 polybar picom polkit-gnome dex xfce4-power-manager rofi dunst lxappearance nitrogen thunar flameshot desktop-file-utils libnotify xpad
else
	paru -S xfce4 xfce4-goodies 
fi

# Instalando aplicacion de utilidad
paru -S community/exa community/ripgrep bat fd xclip zathura zathura-pdf-mupdf htop seahorse mugshot grub-customizer ffmpeg font-manager mpv vlc sct tty-clock xarchiver thunar-archive-plugin thunar-media-tags-plugin thunar-volman 

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

if [ $WN == "i3" ]; then

sudo tee /etc/lightdm/lightdm-gtk-greeter.conf > /dev/null <<'EOF'
[greeter]
background = /usr/share/backgrounds/display-manager-bg/background
theme-name = Nordic
icon-theme-name = NordArc-icons
EOF
	# "Creando carpeta display-manager-bg en /usr/share/backgrounds"
	sudo mkdir -p /usr/share/backgrounds/display-manager-bg
	sudo cp -v Sources/background/default_wallpaper.png /usr/share/backgrounds/display-manager-bg/background

	# "Creando archivo bg-saved.cfg"
	NITRO_PATH=$HOME_USUARIO/.config/nitrogen

	mkdir -p $NITRO_PATH
	cat <<EOF >> $NITRO_PATH/bg-saved.cfg
[xin_-1]
file=$HOME/Sources/background/default_wallpaper.png
mode=0
bgcolor=#000000
EOF
fi

# "Descargando tema de grub en Downloads"
curl -Lo Downloads/arch.tar https://github.com/AdisonCavani/distro-grub-themes/releases/latest/download/arch.tar

# "Iniciando servicios de lightdm"
sudo systemctl enable --now lightdm

echo "La instalacion del sistema ha terminado, se recomienda REINICIAR el sistema, para que los cambios surjan efecto."
