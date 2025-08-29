#!/usr/bin/env bash

echo "Installing necessary packages"

#sudo pacman -S --noconfirm --needed ansible-core xdg-user-dirs

echo "Creating xdg directories"
#xdg-user-dirs-update

echo "Installing system"
ansible-playbook ansible/main.yml --ask-become-pass -e "do_pass=$1" $2

