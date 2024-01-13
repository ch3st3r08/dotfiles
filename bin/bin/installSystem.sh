#!/bin/bash

#Initial configuration
#i3 or xfce4
WM="i3"
#FALTA DECIDIR SI SE CREA OTRO ARCHIVO
echo "Se procederá a instalar los archivos necesarios del sistema: "
echo "---------------------------------------------------------------"
sudo apt install build-essential libsecret-1-0 libsecret-1-dev xorg lm-sensors mesa-utils network-manager-gnome pulseaudio lightdm light-locker lightdm-gtk-greeter-settings neovim neofetch alacritty gvfs gvfs-fuse gvfs-backends thunar-volman thunar-archive-plugin thunar-data thunar-media-tags-plugin pavucontrol mugshot grub-customizer plymouth plymouth-themes firmware-linux zsh gtk2-engines-murrine

if [ $WM == "i3" ]; then
	sudo apt install i3 polybar picom lxpolkit lxsession-data xfce4-power-manager rofi dunst libnotify-bin dex xdg-utils desktop-file-utils lxterminal lxappearance nitrogen thunar 
else
	sudo apt install xfce4 xfce4-goodies
fi

# "Instalando aplicaciones de utilidad"
sudo apt install fd-find ripgrep xclip xarchiver exa mupdf yt-dlp ffmpeg xpad xsct vlc font-manager seahorse galculator tty-clock cava bsdmainutils mpv evince imagemagick htop psmisc -y

# Compile libsecret for debian
sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret

# "Instalando #-NVM (node version manager)"
export NVM_DIR="$HOME/.nvm"
git clone https://github.com/nvm-sh/nvm.git $NVM_DIR
cd $NVM_DIR
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
cd $HOME

# "Instalando #-Nerdfonts"
mkdir -p $HOME/.local/share/fonts
cp -v Sources/fonts/* $HOME/.local/share/fonts
sudo fc-cache -fv

# "Creando directorio de themes e íconos"
mkdir -p $HOME/.local/share/themes
mkdir -p $HOME/.local/share/icons

# "Instalando tema Nord, Nord Icon y Nord Cursor de forma Global"
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
curl -Lo Downloads/debian.tar https://github.com/AdisonCavani/distro-grub-themes/releases/latest/download/debian.tar

# "Instalando tema Plymouth debian"
cd Sources
curl -LO https://gitlab.com/oficsu/kreelista/-/archive/master/kreelista-master.tar.gz
tar -xvaf kreelista-master.tar.gz
cd kreelista-master
sudo make install
sudo plymouth-set-default-theme -R kreelista
cd $HOME

dotfiles config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret
info "La instalacion del sistema ha terminado, se recomienda REINICIAR el sistema, para que los cambios surjan efecto."
