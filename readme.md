# Indicaciones Generales

## Lo primero: Instalar Sudo y Git, agregarnos al grupo sudo y generar los directorios XDG, y cerrar sesion
      su -
      apt install sudo git -y
      usermod -aG sudo [user]
      exit
      xdg-user-dirs-update
      exit

## Luego hay que descargar los DOTFILES de github
      mkdir -p .dotfiles
      alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
      echo ".dotfiles" >> .gitignore
      git clone --bare https://github.com/ch3st3r08/dotfiles $HOME/.dotfiles
      rm -f .bashrc
      config checkout
      config config --local status.showUntrackedFiles no

## Dar permisos de ejecucion y ejecutar el script ~/bin/installSystem.sh 
      chmod u+x bin/installSystem.sh
      sudo ./bin/installSystem.sh [user]

## Luego de la instalacion...
Antes de reiniciar es necesario modificar:
- Comentar linea 'v-sync' en la configuración de Picom solo SI se usa maquina virtual
- Cambiar nombre de interfaz de red en la configuración de Polybar
- Eliminar la configuración de red en /etc/network/interfaces

# Listado de paquetes principales instalados
- Build-essential
- Include backports
- Libsecret
- Git
- Curl
- DOTFILES
- XORG
- I3wm (HEAD)
- Polybar
- Picom
- Network Manager
- PulseAudio (Audio server, frontend for ALSA)
- Polkit Agent
- Xfce4-power-manager
- LightDM
- Rofi (1.7.0)
- Dunst (Notification service)
- Dex (XDG-AUTOSTART implementation)
- XDG utils
- Nodejs
- Neofetch
- Neovim
- Xscreensaver
- Rustup
- Startship
- Alacritty (0.9.0)
- Lxterminal
- Nerdfonts
- Lxappearance (GTK theme customizer)
- Pcmanfm (GUI File Manager)
- Nitrogen (background setter)
- Ranger (Console file manager)
- Feh
- Pavucontrol

### At this point, reboot the system

## Listado de aplicaciones GUI instaladas
- VLC
- Font-manager
- Evince (advanced PDF Reader)
- galculator (calculadora científica)
- Seahorse (gpnu keys and passwords)
- OpenShoot (Video editor)
- OBS (Screen Recorder)
- MuPDF (Lightweight PDF Reader) 
- youtube-dl
- Pureline
- ffmpeg
- xpad
- sct (Temperature monitor)
      sudo apt install mupdf youtube-dl ffmpeg xpad xdg-utils libfile-mimeinfo-perl sct vlc font-manager seahorse galculator

### Firmware 
- firmware-realtek
- firmware-misc-nonfree

### Temas (Crear directorio .themes .icons .local/share/themes .local/share/icons)
- Nord Theme (crear directorio .themes) https://github.com/EliverLara/Nordic
- NordArc Icon theme (crear directorio .icons) https://github.com/robertovernina/NordArc


### Fonts (URL: https://github.com/ryanoasis/nerd-fonts)
- Sauce Code Pro Nerd Font
- TerminessTTF Nerd Font
- Fira Regular Nerd Font
- Hack Regular Nerd Font
- Anonymice Nerd Font
- DejaVu Sans Mono Nerd Font

### Window Manager, Compositor, bar/panel
- i3-gaps (Cambiar directorio de backgrounds)
- picom
- polybar


### Neovim Coc-plugins
- coc-tsserver
- coc-html
- coc-css
- coc-vetur
- coc-json
- coc-python
- coc-git
