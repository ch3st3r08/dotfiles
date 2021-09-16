

#Listado de paquetes instalados
-Sudo
   su -
   apt install sudo
   usermod -aG sudo [user],
   exit
-Build-essential
   sudo apt install build-essential
-Include backports
   echo "deb http://deb.debian.org/debian/ bulleyes-backports main contrib non-free" | sudo tee -a /etc/apt/sources.list >/dev/null
   sudo apt update
-Libsecret
   sudo apt install libsecret-1-0 libsecret-1-dev
-Git
   sudo apt install git
   sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret
-Curl
   sudo apt install curl
-XORG
   sudo apt install xorg, firmware-misc-nonfree, lm-sensors, mesa-utils [firmware-amd-graphics]
-I3wm (HEAD)
   sudo apt install meson
   sudo apt install dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev /
   libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev /
   libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev /
   libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev
   mkdir -p Sources && cd Sources
   git clone https://www.github.com/Airblader/i3 i3-gaps
   cd i3-gaps
   mkdir -p build && cd build
   meson ..
   ninja
   sudo ninja install
   cd $HOME
-Picom
   sudo apt install picom
-Network Manager
   sudo apt install network-manager-gnome
-PulseAudio (Audio server, frontend for ALSA)
   sudo apt install pulseaudio
-Polkit Agent
   sudo apt install lxpolkit lxsession-data
-LightDM
   sudo apt install lightdm light-locker
-Rofi (1.7.0)
   git clone -b 1.7.0 --depth 1 https://github.com/davatorium/rofi Sources/rofi
   sudo apt install bison flex check libgdk-pixbuf-2.0 libxcb-ewmh-dev 
   cd Sources/rofi
   mkdir build && cd build
   ../configure
   make
   sudo make install
   cd $HOME
-Dunst (Notification service)
   sudo apt install dunst libnotify-bin
-Dex (XDG-AUTOSTART implementation)
   sudo apt install dex
-Nodejs
   curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
   sudo apt install nodejs -y
-Neofetch
   sudo apt install neofetch
-Nerdfonts
   mkdir -p .local/share/fonts
   mv Sources/fonts/* .local/share/fonts
   fc-cache -fv
-Neovim
   curl -L -o Downloads/nvim https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage
   chmod +x Downloads/nvim
   sudo mv Downloads/nvim /usr/local/bin
-Xscreensaver
   sudo apt install xscreensaver
-Rustup
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
-Startship
   sudo sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y
Alacritty (0.9.0)
   apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 gzip
   git clone -b 0.9.0 --depth 1 http://github.com/alacritty/alacritty Sources/alacritty
   cd Sources/alacritty
   cargo build --release
   sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
   sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
   sudo desktop-file-install extra/linux/Alacritty.desktop
   sudo update-desktop-database
   sudo mkdir -p /usr/local/share/man/man1
   gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
-Lxterminal
   sudo apt install lxterminal
-DOTFILES
   alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
   echo ".dotfiles" >> .gitignore
   git clone --bare https://github.com/ch3st3r08/dotfiles $HOME/.dotfiles
   rm -f .bashrc
   config checkout
   dotfiles config --local status.showUntrackedFiles no
-Lxappearance (GTK theme custimizer)
   sudo apt install lxappearance gvfs
-Pcmanfm (GUI File Manager)
   sudo apt install pcmanfm
-Nitrogen (background setter)
   sudo apt install nitrogen
-Ranger (Console file manager)
   sudo apt install ranger gpm atool caca-utils mupdf-tools dict dict-wn / 
   python3-pygments mediainfo exiftool poppler-utils libsixel-bin rar
-Feh
   sudo apt install feh

#At this point, reboot the system

#Listado de aplicaciones GUI instaladas
VLC
Font-manager
Evince (advanced PDF Reader)
galculator (calculadora científica)
Seahorse (gpnu keys and passwords)
OpenShoot (Video editor)
OBS (Screen Recorder)
MuPDF (Lightweight PDF Reader) 
youtube-dl
Pureline
ffmpeg
xpad
XGD-utils
sct (Temperature monitor)
   sudo apt install mupdf youtube-dl ffmpeg xpad xdg-utils libfile-mimeinfo-perl sct vlc font-manager seahorse galculator

#Firmware 
firmware-realtek
firmware-misc-nonfree

#Temas
Nord Theme (crear directorio .themes)
NordArc Icon theme (crear directorio .icons)


#Fonts (URL: https://github.com/ryanoasis/nerd-fonts)
Sauce Code Pro Nerd Font
TerminessTTF Nerd Font
Fira Regular Nerd Font
Hack Regular Nerd Font
Anonymice Nerd Font
DejaVu Sans Mono Nerd Font

#Window Manager, Compositor, bar/panel
i3-gaps (Cambiar directorio de backgrounds)
picom
polybar

#Autostart
-Polkit agent(elegit entre los varios agentes)
-nm-applet
-light-locker ()
-start-pulseaudio-x11
-dunstd
-xdg-user-dirs-update (update user dirs XDG)
-xiccd (profile color manager)

#Neovim Coc-plugins
coc-tsserver
coc-html
coc-css
coc-vetur
coc-json
coc-python
coc-git
