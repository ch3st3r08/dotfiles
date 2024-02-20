#!/bin/bash

_DEBUG=0
IS_VM=1
WM="hypr" #xfce4

pre_packages=""
if [ -z $(which stow 2>/dev/null) ]; then
	pre_packages="${pre_packages} stow"
fi

if [ -z $(which xdg-user-dirs-update 2>/dev/null) ]; then
	pre_packages="${pre_packages} xdg-user-dirs"
fi

if ! [ -z "$pre_packages" ]; then
	sudo pacman -S $pre_packages
fi

cd $HOME

#XDG directories
xdg-user-dirs-update

#Descargar e instalar Paru (AUR helper)
git clone https://aur.archlinux.org/paru.git Sources/paru
cd Sources/paru
makepkg -si

cd $HOME

rm -f $HOME/.bashrc

cd .dotfiles
stow -S alacritty hypr nvim starship git waybar tmux zsh rofi sources music bin bash misc

echo "---------------------------------------------------------------"
echo "Instalando archivos necesarios"
paru -S curl pacman-contrib networkmanager network-manager-applet zsh tmux gvfs gvfs-smb gvfs-nfs pipewire pipewire-audio pipewire-pulse wireplumber gst-plugin-pipewire thunar xdg-utils fastfetch neovim starship alacritty unzip pavucontrol brave-browser gtk-engine-murrine mpd ncmpcpp rhythmbox xorg-server xorg-xinit iwd libva-mesa-driver intel-media-driver sound-theme-freedesktop xf86-video-amdgpu

if [ $WM == "hypr" ]; then
	paru -S hyprland xdg-desktop-portal-hyprland sddm waybar rofi swaync swayidle waylock swaybg nwg-bar nwg-look-bin azote polkit polkit-kde-agent desktop-file-utils nwg-displays nwg-drawer-bin nwg-shell-config nwg-icon-picker nwg-menu-bin hyprpicker gtklock wf-recorder ristretto cliphist galculator qt5-wayland qt6-wayland
else
	paru -S xfce4 xfce4-goodies mugshot sct wmctrl timeshift xclip
fi

# Instalando aplicacion de utilidad
paru -S eza ripgrep bat fd fzf lazygit zathura zathura-pdf-mupdf htop seahorse grub-customizer ffmpeg font-manager mpv vlc reflector tty-clock xarchiver thunar-archive-plugin thunar-media-tags-plugin thunar-volman ttf-hack-nerd ttf-iosevka-nerd ttf-firacode-nerd ttf-sourcecodepro-nerd ttf-terminus-nerd ttf-font-awesome otf-codenewroman-nerd plymouth plymouth-theme-arch10 dracula-gtk-theme nordic-theme nordzy-cursors nordzy-icon-theme whitesur-icon-theme

echo "---------------------------------------------------------------"
info "Instalando #-NVM (node version manager)"
export NVM_DIR="$HOME/.nvm"
git clone https://github.com/nvm-sh/nvm.git $NVM_DIR
cd $NVM_DIR
git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))
cd $HOME

# "Iniciando servicios de lightdm"
sudo systemctl enable --now sddm.service

echo "La instalacion del sistema ha terminado, se recomienda REINICIAR el sistema, para que los cambios surjan efecto."
