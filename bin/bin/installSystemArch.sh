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
	sudo pacman -S --needed --noconfirm $pre_packages
fi

cd $HOME

#XDG directories
xdg-user-dirs-update

#Descargar e instalar Paru (AUR helper)
git clone https://aur.archlinux.org/paru-bin.git Sources/paru
cd Sources/paru
makepkg -si

cd $HOME

rm -f $HOME/.bashrc

cd .dotfiles
stow -S alacritty pdf-reader nvim starship git tmux zsh sources music bin bash misc

echo "---------------------------------------------------------------"
echo "Instalando archivos necesarios"
paru -S --needed --noconfirm curl pacman-contrib networkmanager sddm network-manager-applet zsh tmux gvfs gvfs-smb gvfs-nfs pipewire pipewire-audio pipewire-pulse wireplumber gst-plugin-pipewire thunar xdg-utils fastfetch neovim starship alacritty unzip pavucontrol brave-browser gtk-engine-murrine mpd ncmpcpp rhythmbox iwd libva-mesa-driver intel-media-driver sound-theme-freedesktop xf86-video-amdgpu

if [ $WM == "hypr" ]; then
        cd .dotfiles
        stow -S hypr waybar rofi
        cd $HOME
	paru -S --needed --noconfirm hyprland xdg-desktop-portal-hyprland waybar rofi-lbonn-wayland swaync hypridle hyprlock hyprcursor swaybg nwg-bar nwg-look-bin waypaper polkit polkit-gnome desktop-file-utils nwg-displays nwg-drawer-bin nwg-icon-picker nwg-menu-bin hyprpicker wf-recorder ristretto cliphist qt5-wayland qt6-wayland swappy slurp grim
else
        cd .dotfiles
        stow -S xfce4
        cd $HOME
	paru -S --needed --noconfirm xorg-server xorg-xinit xfce4 xfce4-goodies mugshot wmctrl timeshift-gtk xclip menulibre
fi

# Instalando aplicacion de utilidad
paru -S --needed --noconfirm nvm galculator p7zip entr zoxide eza ripgrep bat bat-extras fd fzf lazygit zathura zathura-pdf-mupdf htop seahorse lssecret-git grub-customizer ffmpeg font-manager mpv vlc reflector tty-clock xarchiver thunar-archive-plugin thunar-media-tags-plugin thunar-volman ttf-hack-nerd ttf-iosevka-nerd ttf-firacode-nerd ttf-sourcecodepro-nerd ttf-terminus-nerd ttf-font-awesome otf-codenewroman-nerd plymouth plymouth-theme-arch-logo-new dracula-gtk-theme nordic-theme nordzy-cursors nordzy-icon-theme ttf-ms-fonts 

# "Iniciando servicios de lightdm"
sudo systemctl enable --now sddm.service

echo "La instalacion del sistema ha terminado, se recomienda REINICIAR el sistema, para que los cambios surjan efecto."
