#!/bin/bash

_DEBUG=0
IS_VM=0
IS_SID=0

while getopts 'hsvd' OPTION; do
  case "$OPTION" in
    h)
      echo "Usage: $0 [-h] [-s] [-v] username"
      ;;
    s)
      IS_SID=1
      ;;
    v)
      IS_VM=1
      ;;
    d)
      _DEBUG=1
      ;;
    *)
      echo "Usage: $0 [-h] [-s] [-v] username" >&2
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


if [[ -z $1 ]]; then
  error "Es necesario un nombre de usuario"
  exit 1
fi

if [[ $(id -u) -ne 0 ]]; then
  error "Se necesitan privilegios administrativos"
  exit 1
fi

if ! id "$1" &>/dev/null; then
  error "No se ha encontrado al usuario $1"
  exit 1
fi

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
if [[ $IS_SID -eq 0 ]]; then
  echo "deb http://deb.debian.org/debian/ bullseye-backports main contrib non-free" | tee -a /etc/apt/sources.list >/dev/null
  apt update
fi

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

info "Instalando #-I3wm (latest tag)"
apt install meson dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb \
  libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev \
  libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev \
  libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev -y
mkdir -p Sources && cd Sources
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
git checkout `git describe --abbrev=0 --tags --match "[0-9]*" $(git rev-list --tags --max-count=1)`
mkdir -p build && cd build
meson ..
ninja
ninja install
cd $HOME_USUARIO

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando Polybar"
if [[ $IS_SID -eq 0 ]]; then
  git clone --recursive https://github.com/polybar/polybar Sources/polybar
  apt install cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev
  cd Sources/polybar
  git checkout `git describe --abbrev=0 --tags --match "[0-9]*" $(git rev-list --tags --max-count=1)`
  mkdir -p build && cd build
  cmake ..
  make -j$(nproc)
  make install

else
  apt install polybar -y
fi

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Picom (latest tag)"
if [[ $IS_SID -eq 0 ]]; then
  git clone https://github.com/yshui/picom Sources/picom
  apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson -y
  cd Sources/picom
  git checkout `git describe --abbrev=0 --tags --match "[0-9]*" $(git rev-list --tags --max-count=1)`
  git submodule update --init --recursive
  meson --buildtype=release . build
  ninja -C build
  ninja -C build install
  cd $HOME_USUARIO
else
  apt install picom -y
fi

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

info "Instalando #-Rofi (latest tag)"
if [[ $IS_SID -eq 0 ]]; then
  git clone https://github.com/davatorium/rofi Sources/rofi
  apt install bison flex check libgdk-pixbuf-2.0-0 libgdk-pixbuf-2.0-dev libxcb-ewmh-dev -y
  cd Sources/rofi
  git checkout `git describe --abbrev=0 --tags --match "[0-9]*" $(git rev-list --tags --max-count=1)`
  git submodule update --init --recursive
  autoreconf -i
  mkdir -p build && cd build
  ../configure
  make
  make install
  cd $HOME_USUARIO
else
  apt install rofi -y
fi

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Dunst (Notification service)"
if [[ $IS_SID -eq 0 ]]; then
  git clone https://github.com/dunst-project/dunst Sources/dunst
  apt install libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev libnotify-bin -y
  cd Sources/dunst
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  make
  sudo make install
  cd $HOME_USUARIO
else
  apt install dunst libnotify-bin -y
fi

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

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Neofetch"
apt install neofetch -y

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando #-Neovim"
if [[ $IS_SID -eq 0]]; then
  curl -L -o Downloads/nvim https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod +x Downloads/nvim
  mv Downloads/nvim /usr/local/bin
else
  apt install neovim -y
fi

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

info "Instalando #Alacritty (latest tag)"
apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 gzip -y
git clone http://github.com/alacritty/alacritty Sources/alacritty
cd Sources/alacritty
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
cargo build --release
cp target/release/alacritty /usr/local/bin
cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
desktop-file-install extra/linux/Alacritty.desktop
update-desktop-database
mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
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
apt install ranger gpm atool caca-utils mupdf-tools python3-pygments librsvg2-bin mediainfo exiftool libsixel-bin unrar -y

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
apt install fd-find ripgrep xclip xarchiver exa mupdf youtube-dl ffmpeg xpad sct vlc font-manager seahorse galculator tty-clock cava bsdmainutils mpv evince -y

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
curl -Lo Downloads/debian.tar https://github.com/AdisonCavani/distro-grub-themes/releases/latest/download/debian.tar

if [[ $_DEBUG -eq 1 ]]; then ask; fi

info "Instalando tema Plymouth debian"
cd Sources
curl -LO https://gitlab.com/oficsu/kreelista/-/archive/master/kreelista-master.tar.gz
tar -xvaf kreelista-master.tar.gz
cd kreelista-master
make install
plymouth-set-default-theme -R kreelista
cd $HOME_USUARIO

info "Actualizando permisos en directorio Sources"
chown -R $1:$1 Sources

info "La instalacion del sistema ha terminado, se recomienda REINICIAR el sistema, para que los cambios surjan efecto."

