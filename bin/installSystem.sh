#!/bin/bash

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

if [[ $(id -u) -ne 0 ]]; then
   error "Se necesitan privilegios administrativos"
   exit 1
fi

if ! id "$1" &>/dev/null; then
   error "No se ha encontrado al usuario $1"
   exit 1
fi

_DEBUG=1
IS_VM=1
HOME_USUARIO="/home/$1"

if [[ ! -d $HOME_USUARIO ]]; then
   error "No existe directorio $1"
   exit 1
fi

cd $HOME_USUARIO

echo "Se procederá a instalar los archivos necesarios del sistema: "
echo "---------------------------------------------------------------"
info "Instalando #-Build-essential"
apt install build-essential -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Include backports"
   echo "deb http://deb.debian.org/debian/ bullseye-backports main contrib non-free" | tee -a /etc/apt/sources.list >/dev/null
   apt update

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Libsecret y compilando integracion con Git"
   apt install libsecret-1-0 libsecret-1-dev -y
   make --directory=/usr/share/doc/git/contrib/credential/libsecret

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Curl"
   apt install curl -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-XORG"
if [[ $IS_VM -eq 1 ]]; then
   apt install xorg lm-sensors mesa-utils -y
else
   apt install xorg firmware-misc-nonfree lm-sensors mesa-utils firmware-amd-graphics -y
fi

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-I3wm (HEAD)"
   apt install meson dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb \
      libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev \
      libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev \
      libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev -y
   mkdir -p Sources && cd Sources
   git clone https://www.github.com/Airblader/i3 i3-gaps
   cd i3-gaps
   mkdir -p build && cd build
   meson ..
   ninja
   ninja install
   cd $HOME_USUARIO

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando Polybar"
   apt install polybar -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Picom"
   apt install picom -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Network Manager"
   apt install network-manager-gnome -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-PulseAudio (Audio server, frontend for ALSA)"
   apt install pulseaudio -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Polkit Agent"
   apt install lxpolkit lxsession-data -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Xfce4-power-manager"
   apt install xfce4-power-manager -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-LightDM"
   apt install lightdm light-locker lightdm-gtk-greeter-settings -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Rofi (1.7.2)"
   git clone -b 1.7.2 --depth 1 https://github.com/davatorium/rofi Sources/rofi
   apt install bison flex check libgdk-pixbuf-2.0-0 libgdk-pixbuf-2.0-dev libxcb-ewmh-dev -y
   cd Sources/rofi
   git submodule update --init --recursive
   autoreconf -i
   mkdir -p build && cd build
   ../configure
   make
   make install
   cd $HOME_USUARIO

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Dunst (Notification service)"
   apt install dunst libnotify-bin -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Dex (XDG-AUTOSTART implementation)"
   apt install dex -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-XDG utils y desktop-file-utils"
   apt install xdg-utils desktop-file-utils -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-NVM (node version manager)"

  export NVM_DIR="$HOME_USUARIO/.nvm"
  git clone https://github.com/nvm-sh/nvm.git $NVM_DIR
  cd $NVM_DIR
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  cd $HOME_USUARIO
  chown -R $1:$1 $NVM_DIR

#info "Instalando #-Nodejs"
   #curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
   #apt install nodejs -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Neofetch"
   apt install neofetch -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Neovim"
   curl -L -o Downloads/nvim https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage
   chmod +x Downloads/nvim
   mv Downloads/nvim /usr/local/bin

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Xscreensaver"
   sudo apt install xscreensaver -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Rustup"
   export CARGO_HOME=$HOME_USUARIO/.cargo
   export RUSTUP_HOME=$HOME_USUARIO/.rustup
   export PATH=$PATH:$CARGO_HOME/bin
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
   chown -R $1:$1 $CARGO_HOME $RUSTUP_HOME

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Startship"
   sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #Alacritty (0.9.0)"
   apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 gzip -y
   git clone -b v0.9.0 --depth 1 http://github.com/alacritty/alacritty Sources/alacritty
   cd Sources/alacritty
   cargo build --release
   cp target/release/alacritty /usr/local/bin
   cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
   desktop-file-install extra/linux/Alacritty.desktop
   update-desktop-database
   mkdir -p /usr/local/share/man/man1
   gzip -c extra/alacritty.man | tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
   cd $HOME_USUARIO

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Lxterminal"
   apt install lxterminal -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Nerdfonts"
   install -d -o $1 -g $1 $HOME_USUARIO/.local/share/fonts
   cp -v Sources/fonts/* $HOME_USUARIO/.local/share/fonts
   sudo -u $1 fc-cache -fv

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Lxappearance (GTK theme customizer)"
   apt install lxappearance gvfs -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Pcmanfm (GUI File Manager)"
   apt install pcmanfm -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Nitrogen (background setter)"
   apt install nitrogen -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Ranger (Console file manager)"
   apt install ranger gpm atool caca-utils mupdf-tools dict dict-wn \
   python3-pygments mediainfo exiftool poppler-utils libsixel-bin unrar -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Feh"
   apt install feh -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando Pulseaudio Control"
   apt install pavucontrol -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando Mugshot"
   apt install mugshot -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando Grub Customizer"
   apt install grub-customizer -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando aplicaciones de utilidad"
   apt install fd-find ripgrep xclip xarchiver exa mupdf youtube-dl ffmpeg xpad sct vlc font-manager seahorse galculator -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Creando directorio de themes e íconos"
   install -d -o $1 -g $1 $HOME_USUARIO/.local/share/themes
   install -d -o $1 -g $1 $HOME_USUARIO/.local/share/icons


if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando tema Nord, Nord Icon y Nord Cursor de forma Global"
   git clone https://github.com/EliverLara/Nordic Sources/Nordic_theme
   git clone https://github.com/robertovernina/NordArc Sources/NordArc_icon_theme
   git clone https://github.com/alvatip/Nordzy-cursors Sources/Nordzy-cursors
   cp -R Sources/Nordic_theme /usr/share/themes/Nordic
   cp -R Sources/NordArc_icon_theme/NordArc-Icons /usr/share/icons
   cp -R Sources/Nordzy-cursors/Nordzy-cursors /usr/share/icons
   cp -R Sources/Nordzy-cursors/Nordzy-cursors-white /usr/share/icons

info "Configurando propiedades default del lightdm-gtk-greeter-settings"
cat <<'EOF' >> /etc/lightdm/lightdm-gtk-greeter.conf
[greeter]
background = /usr/share/backgrounds/display-manager-bg/background
theme-name = Nordic
icon-theme-name = NordArc-icons
EOF

info "Creando carpeta display-manager-bg en /usr/share/backgrounds"
install -d /usr/share/backgrounds/display-manager-bg
cp -v Sources/background/default_wallpaper.png /usr/share/backgrounds/display-manager-bg/background

info "Creando archivo bg-saved.cfg"
NITRO_PATH=$HOME_USUARIO/.config/nitrogen

install -d -o $1 -g $1 $NITRO_PATH
cat <<EOF >> $NITRO_PATH/bg-saved.cfg
[xin_-1]
file=$HOME_USUARIO/Sources/background/default_wallpaper.png
mode=0
bgcolor=#000000
EOF
chown -vR $1:$1 $NITRO_PATH/bg-saved.cfg

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Descargando tema de grub en Downloads"
curl -Lo Downloads/debian.tar https://github.com/AdisonCavani/distro-grub-themes/releases/download/v2.3/debian.tar

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando tema Plymouth debian"
cd Sources
curl -LO https://gitlab.com/maurom/deb10/-/archive/master/deb10-master.tar.gz
tar -xvaf deb10-master.tar.gz
cd deb10-master
make install
plymouth-set-default-theme -R deb10
cd $HOME_USUARIO

info "Actualizando permisos en directorio Sources"
chown -R $1:$1 Sources

info "La instalacion del sistema ha terminado, se recomienda REINICIAR el sistema, para que los cambios surjan efecto."

