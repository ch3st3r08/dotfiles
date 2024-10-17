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

function someError() {
    # $1 = errorCode
    # $2 = ErrorMsg
    if [[ $? -ne $1 ]]; then
        echo "Error: $2"
        exit
    fi
}

function configXfce4() {
    if [[ $WM == "xfce4" ]]; then
        cat <<EOF >>~/.config/gtk-3.0/gtk.css
.xfce4-panel#XfcePanelWindow {
   border-radius: 10px;
}
EOF

    fi
}

#Default variables
_DEBUG=0
IS_VM=0
_EXISTING=0
WM="xfce4" #hypr

while getopts ":hebmdw:" option; do
    case $option in
    h)
        Help
        exit
        ;;
    e)
        _EXISTING=1
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
MAIN_PACKAGES="curl tree archlinux-contrib pacman-contrib networkmanager network-manager-applet sddm zsh tmux pipewire pipewire-audio pipewire-pulse wireplumber gst-plugin-pipewire gvfs gvfs-smb gvfs-nfs thunar xdg-utils fastfetch neovim starship alacritty unzip pavucontrol brave-browser gtk-engine-murrine mpd ncmpcpp rhythmbox iwd libva-mesa-driver intel-media-driver sound-theme-freedesktop xf86-video-amdgpu"

SPECIFIC_PACKAGES=""

if [[ $WM == "hypr" ]]; then
    SPECIFIC_PACKAGES=" hyprland xdg-desktop-portal-hyprland waybar rofi-wayland swaync hypridle hyprlock hyprcursor swaybg nwg-bar-bin nwg-look-bin waypaper polkit polkit-gnome desktop-file-utils nwg-displays nwg-drawer-bin nwg-icon-picker nwg-menu-bin hyprpicker wf-recorder ristretto cliphist qt5-wayland qt6-wayland swappy slurp grim wvkbd"
else

    SPECIFIC_PACKAGES=" xorg-server xorg-xinit xfce4 xfce4-goodies xfce4-panel-profiles gigolo transmission-gtk catfish atril mugshot wmctrl redshift xclip menulibre gst-libav gcolor3 qtvkbd conky"
fi

utility_cmd_programs="fzf eza fd ripgrep bat bat-extras zoxide entr p7zip htop reflector lazygit mpv zathura zathura-pdf-mupdf tty-clock distro-grub-themes-arch nvm lssecret-git ffmpeg plymouth plymouth-theme-arch-logo-new informant rsync grsync rclone"

utility_ui_programs=" galculator seahorse grub-customizer font-manager vlc xarchiver thunar-archive-plugin thunar-media-tags-plugin thunar-volman sddm-conf-git baobab gparted thunderbird"

utility_fonts=" ttf-hack-nerd ttf-iosevka-nerd ttf-firacode-nerd ttf-sourcecodepro-nerd ttf-terminus-nerd ttf-font-awesome otf-codenewroman-nerd ttf-ms-fonts"

utility_themes=" nordic-theme nordzy-cursors kora-icon-theme"

UTILITY_PACKAGES="$utility_cmd_programs$utility_ui_programs$utility_fonts$utility_themes"

paru -S --needed --noconfirm $MAIN_PACKAGES $SPECIFIC_PACKAGES $UTILITY_PACKAGES

if [[ $? -ne 0 ]]; then
    echo "Error: error al descargar, se aborta la instalación"
    exit
fi

cd .dotfiles
stow --dotfiles --no-folding -S alacritty pdf-reader nvim starship git tmux zsh sources music util-scripts bash misc
if [[ $WM == "hypr" ]]; then
    stow --dotfiles --no-folding -S hypr waybar rofi
else
    # Si existe la carpeta hacer esto:
    if [ -d $HOME/.config/xfce4/xfconf ]; then
        stow -S --dotfiles --no-folding --adopt xfce4
        git restore *
    else
        stow -S --dotfiles --no-folding xfce4
    fi
    configXfce4
fi

systemctl is-active --quiet systemd-timesync || sudo systemctl enable --now systemd-timesyncd.service
systemctl is-active --quiet sddm || sudo systemctl enable --now sddm.service

echo "Nota: Si quieres tener los wallpapers, descargalos a la ubicacion /usr/share/backgrounds y symlink a Pictures"
echo "Nota: Si quieres thema de Sddm, descargalo e instalalo en la ubicación /usr/share/sddm/themes y modifica el archivo sddm.conf "
echo "--------------------------------------------------"
echo "La instalacion del sistema ha terminado, se recomienda REINICIAR el sistema, para que los cambios surjan efecto."
