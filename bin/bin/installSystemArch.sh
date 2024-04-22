#!/bin/bash

function Help() {
	echo "Install the system and configurations."
	echo
	echo "Syntax: $0 [-b|m|w|h|d]"
	echo "options:"
	echo "-b  Enable debug messages"
	echo "-m  Virtual Machine installation"
	echo "-w  Desktop name (hypr | xfce4) default 'xfce4'"
	echo "-d  Print installation arguments"
	echo "-h  Print this message."
	echo
}

function Dry() {
	echo "----------------------------"
	echo "Valor de Debug = $_DEBUG"
	echo "Valor de IS_VM = $IS_VM"
	echo "Valor de WM = $WM"
	echo "----------------------------"
}

#Default variables
_DEBUG=0
IS_VM=0
WM="xfce4" #hypr

while getopts ":hbmdw:" option; do
	case $option in
	h)
		Help
		exit
		;;
	b)
		_DEBUG=1
		;;
	m)
		IS_VM=1
		;;
	w)
		WM=$OPTARG
		;;
	d)
		Dry
		exit
		;;
	\?)
		echo "Error: Invalid option"
		Help
		exit
		;;
	esac
done

# Core packages for installation
sudo pacman -S --needed --noconfirm git stow xdg-user-dirs-update

cd $HOME

#XDG directories
xdg-user-dirs-update

#Descargar e instalar Paru (AUR helper)
if [ -z $(which paru 2>/dev/null) ]; then
	git clone https://aur.archlinux.org/paru-bin.git Sources/paru
	cd $HOME/Sources/paru
	makepkg -si --noconfirm
	cd $HOME
fi

if [ ! -f $HOME/.bashrc.bak ]; then
	mv .bashrc .bashrc.bak
fi

cd .dotfiles
stow -S alacritty pdf-reader nvim starship git tmux zsh sources music bin bash misc

echo "---------------------------------------------------------------"
echo "Instalando archivos necesarios"
paru -S --needed --noconfirm curl pacman-contrib networkmanager sddm network-manager-applet zsh tmux gvfs gvfs-smb gvfs-nfs pipewire pipewire-audio pipewire-pulse wireplumber gst-plugin-pipewire thunar xdg-utils fastfetch neovim starship alacritty unzip pavucontrol brave-browser gtk-engine-murrine mpd ncmpcpp rhythmbox iwd libva-mesa-driver intel-media-driver sound-theme-freedesktop xf86-video-amdgpu

if [ $WM == "hypr" ]; then
	stow -S hypr waybar rofi
	paru -S --needed --noconfirm hyprland xdg-desktop-portal-hyprland waybar rofi-lbonn-wayland swaync hypridle hyprlock hyprcursor swaybg nwg-bar-bin nwg-look-bin waypaper polkit polkit-gnome desktop-file-utils nwg-displays nwg-drawer-bin nwg-icon-picker nwg-menu-bin hyprpicker wf-recorder ristretto cliphist qt5-wayland qt6-wayland swappy slurp grim
else
	stow -S xfce4
	paru -S --needed --noconfirm xorg-server xorg-xinit xfce4 xfce4-goodies mugshot wmctrl timeshift-gtk xclip menulibre
fi

# Instalando aplicacion de utilidad
paru -S --needed --noconfirm nvm galculator p7zip entr zoxide eza ripgrep bat bat-extras fd fzf lazygit zathura zathura-pdf-mupdf htop seahorse lssecret-git grub-customizer ffmpeg font-manager mpv vlc reflector tty-clock xarchiver thunar-archive-plugin thunar-media-tags-plugin thunar-volman ttf-hack-nerd ttf-iosevka-nerd ttf-firacode-nerd ttf-sourcecodepro-nerd ttf-terminus-nerd ttf-font-awesome otf-codenewroman-nerd plymouth plymouth-theme-arch-logo-new dracula-gtk-theme nordic-theme nordzy-cursors nordzy-icon-theme ttf-ms-fonts sddm-conf-git sddm-sugar-candy-git distro-grub-themes-arch

# "Iniciando servicios de lightdm"
sudo systemctl enable --now sddm.service

echo "La instalacion del sistema ha terminado, se recomienda REINICIAR el sistema, para que los cambios surjan efecto."
