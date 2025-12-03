# Indicaciones Generales

## Lo primero: Instalar Sudo y Git, agregarnos al grupo sudo, y cerrar sesion

### Arch Linux:
```sh
    pacman -Syu sudo git xdg-user-dirs --noconfirm
    usermod -aG sudo [user]
    exit
```

## Luego hay que descargar los DOTFILES de github
```sh
    git clone --recurse-submodules https://github.com/ch3st3r08/dotfiles $HOME/.dotfiles
```

## Luego ejecutar el script de instalación que se encuentra en .dotfile/install.sh
```sh
    ./install.sh
```

## Luego de la instalacion...
Para tema de grub
- Modificar el tema de grub con grub customizer
  - agregar linea **GRUB_BACKGROUND** al archivo **/etc/default/grub**
  - modificar la linea **GRUB_GFXMODE** y agregar resolucion **1090x1200x24,auto**
  - agregar la linea **GRUB_DISABLE_OS_PROBER=false** al archivo **/etc/default/grub**
  
# Listado de paquetes principales instalados
- Git
- Curl
- Hyperland (Wayland Compositor)
- Waybar (StatusBar)
- Alacritty (Terminal Emulator)
- Neovim (Text editor)
- Network Manager (Network Control)
- Pipewire (Audio server, frontend for ALSA) (Audio Control)
- Polkit Agent (Polkit Auth Agent)
- LightDM (Display Manager)
- Swaylock (Screen Locker)
- Rofi (Application Launcher)
- Swaync (Notification service)
- Azote (Background setter)

# Utils
- Starship (Prompt Customizer)
- Xpad (Note app)
- Lxterminal (Alternative terminal)
- Pavucontrol (Audio Control)
- Fastfetch (System stats)
- Nerdfonts (Icon fonts)
- Nwg-look (Look and Feel)
- Tty-clock (terminal clock)
- Bdsmainutils (terminal calendar)
- Cava (Console Audio Visualizer)

# Default Applications
- Thunar (GUI File Manager)
- Brave (Browser)
- Mpv, VLC (Media Player)
- Zathura (pdf reader)
- Rythmbox (Audio Player)
- Ristretto (Image viewer)
- Zathura, Evince (PDF Reader)
- Font Manager
- Galculator
- Seahorse (gpnu keys and passwords)


### At this point, reboot the system

## Listado de aplicaciones GUI instaladas
- OpenShoot (Video editor)
- OBS (Screen Recorder)
- youtube-dl
- ffmpeg
