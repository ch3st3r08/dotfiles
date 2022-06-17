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

## Luego de la instalacion...
Antes de reiniciar es necesario modificar:
- Comentar linea **v-sync** en la configuración de Picom solo SI se usa maquina virtual
- Cambiar de GLX a XRENDER en picom.conf
- Cambiar nombre de interfaz de red en la configuración de Polybar
- Eliminar la configuración de red en **/etc/network/interfaces**
- Activar los temas con lxappearance (tema, iconos, cursores)
- Modificar el **Hidden=true** en el desktop file de lxpolkit en **/etc/xdg/autostart**
- Modificar el tema de grub con grub customizer
  - agregar linea **GRUB_BACKGROUND** al archivo **/etc/default/grub**
  - modificar la linea **GRUB_GFXMODE** y agregar resolucion **1090x1200x24,auto**
  - agregar la linea **GRUB_DISABLE_OS_PROBER=false** al archivo **/etc/default/grub**
- Instalar los LSP servers, luego de abrir NVIM

# Listado de paquetes principales instalados
- Build-essential
- Include backports
- Libsecret
- Git
- Curl
- DOTFILES
- XORG (Desktop Compositor)
- I3wm (Window Manager)
- Polybar (StatusBar)
- Picom (Compositor)
- Network Manager (Network Control)
- PulseAudio (Audio server, frontend for ALSA) (Audio Control)
- Polkit Agent (Polkit Auth Agent)
- Xfce4-power-manager (Power Manager)
- LightDM (Display Manager)
- Light-locker (Screen Locker)
- Rofi (Application Launcher)
- Dunst (Notification service)
- Nitrogen (Background setter)

# Default Applications
- Dex (XDG-AUTOSTART implementation)
- XDG utils
- NVM (node package manager)
- Neofetch
- Neovim
- Rustup
- Startship
- Alacritty
- Lxterminal
- Nerdfonts
- Lxappearance (GTK theme customizer)
- Pcmanfm (GUI File Manager)
- Ranger (Console file manager)
- Feh (Simple Image Viewer)
- Pavucontrol (PulseAudio Control)
- MuPDF (Lightweight PDF Reader)
- Mugshot (Account Services)
- Grub Customizer
- Bdsmainutils (terminal calendar)
- Tty-clock (terminal clock)
- Cava (Console Audio Visualizer)

### At this point, reboot the system

## Listado de aplicaciones GUI instaladas
- VLC
- Font-manager
- Evince (advanced PDF Reader)
- galculator (calculadora científica)
- Seahorse (gpnu keys and passwords)
- OpenShoot (Video editor)
- OBS (Screen Recorder)
- youtube-dl
- Pureline
- ffmpeg
- xpad
- sct (Temperature monitor)
- mpv (Video Player)

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
