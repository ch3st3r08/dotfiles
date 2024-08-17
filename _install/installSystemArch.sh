#!/bin/bash

function configXfce4() {
    if [[ $WM == "xfce4" ]]; then
        cat <<EOF >>~/.config/gtk-3.0/gtk.css
.xfce4-panel#XfcePanelWindow {
   border-radius: 10px;
}
EOF

    fi
}

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

function someError() {
    # $1 = errorCode
    # $2 = ErrorMsg
    if [[ $? -ne $1 ]]; then
        echo "Error: $2"
        exit
    fi
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
sudo pacman -S --needed --noconfirm git stow xdg-user-dirs
if [[ $? -ne 0 ]]; then
    echo "Error: No se pudo descargar los paquetes"
    exit
fi

cd $HOME

#XDG directories
xdg-user-dirs-update

#Descargar e instalar Paru (AUR helper)
if [ -z $(command -v paru 2>/dev/null) ]; then
    git clone https://aur.archlinux.org/paru-bin.git Sources/paru
    if [[ $? -ne 0 ]]; then
        echo "Error: No se pudo descargar Paru"
        exit
    fi
    cd Sources/paru
    makepkg -si --noconfirm
    cd $HOME
fi

if [ ! -f $HOME/.bashrc.bak ]; then
    mv .bashrc .bashrc.bak
fi

# Packages variable
MAIN_PACKAGES="curl pacman-contrib networkmanager sddm network-manager-applet zsh tmux gvfs gvfs-smb gvfs-nfs pipewire pipewire-audio pipewire-pulse wireplumber gst-plugin-pipewire thunar xdg-utils fastfetch neovim starship alacritty unzip pavucontrol brave-browser gtk-engine-murrine mpd ncmpcpp rhythmbox iwd libva-mesa-driver intel-media-driver sound-theme-freedesktop xf86-video-amdgpu
"
SPECIFIC_PACKAGES=""

if [[ $WM == "hypr" ]]; then
    SPECIFIC_PACKAGES=" hyprland xdg-desktop-portal-hyprland waybar rofi-wayland swaync hypridle hyprlock hyprcursor swaybg nwg-bar-bin nwg-look-bin waypaper polkit polkit-gnome desktop-file-utils nwg-displays nwg-drawer-bin nwg-icon-picker nwg-menu-bin hyprpicker wf-recorder ristretto cliphist qt5-wayland qt6-wayland swappy slurp grim"
else

    SPECIFIC_PACKAGES=" xorg-server xorg-xinit xfce4 xfce4-goodies mugshot wmctrl redshift xclip menulibre gst-libav gcolor3"
fi

UTILITY_PACKAGES=" tree nvm galculator p7zip entr zoxide eza ripgrep bat bat-extras fd fzf lazygit zathura zathura-pdf-mupdf htop seahorse lssecret-git grub-customizer ffmpeg font-manager mpv vlc reflector tty-clock xarchiver thunar-archive-plugin thunar-media-tags-plugin thunar-volman ttf-hack-nerd ttf-iosevka-nerd ttf-firacode-nerd ttf-sourcecodepro-nerd ttf-terminus-nerd ttf-font-awesome otf-codenewroman-nerd plymouth plymouth-theme-arch-logo-new dracula-gtk-theme nordic-theme nordzy-cursors ttf-ms-fonts sddm-conf-git distro-grub-themes-arch"

paru -S --needed --noconfirm $MAIN_PACKAGES $SPECIFIC_PACKAGES $UTILITY_PACKAGES

if [[ $? -ne 0 ]]; then
    echo "Error: error al descargar, se aborta la instalación"
    exit
fi

cd .dotfiles
stow --dotfiles --no-folding -S alacritty pdf-reader nvim starship git tmux zsh sources music bin bash misc
if [[ $WM == "hypr" ]]; then
    stow --dotfiles --no-folding -S hypr waybar rofi
else
    stow -S --dotfiles --no-folding --adopt xfce4
    git restore *
    configXfce4
fi

# If not using archinstall, do this
#sudo systemctl enable --now systemd-timesyncd.service
#sudo systemctl enable --now sddm.service
echo "Nota: Si quieres tener los wallpapers, descargalos a la ubicacion /usr/share/backgrounds y symlink a Pictures"
echo "Nota: Si quieres thema de Sddm, descargalo e instalalo en la ubicación /usr/share/sddm/themes y modifica el archivo sddm.conf "
echo "--------------------------------------------------"
echo "La instalacion del sistema ha terminado, se recomienda REINICIAR el sistema, para que los cambios surjan efecto."
