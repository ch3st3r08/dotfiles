#!/usr/bin/env bash
my_help ()
{
    echo "Usage: install.sh [-e DE name] [-t tags] [-l list DE] [-v] "
    exit 0
}
my_error ()
{
  echo "Needs to specify a DE name or a tag. See help -h"
  exit 1
}

list_de ()
{
  _list=$(find . -type d -name "*_desktop" -exec basename {} \; \
    | sed 's/_desktop//')
  echo $_list
}

while getopts "ce:lt:h" opt; do
  case $opt in
    c)
      CHECK="--check"
      ;;
    e)
      DE="$OPTARG"  # Option argument is in $OPTARG
      ;;
    l)
      LIST_DE=1
      ;;
    t)
      TAG="$OPTARG"
      ;;
    h)
      my_help
      ;;
    :)
      echo "Error: -$OPTARG requires an argument"
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
  esac
done

shift $((OPTIND-1))

# Checking repo existences
if [ ! -d $HOME/.dotfiles ]; then
  echo "No existe, hay que crearlos"
  git clone https://github.com/ch3st3r08/dotfiles "$HOME/.dotfiles"
  cd $HOME/.dotfiles
fi

if [[ -z "$TAG" ]] && [[ -z "$DE" ]]; then
  read -ra options <<< $(list_de)
  options+=("Exit")
  PS3='Choose an option: '
  select opt in "${options[@]}"; do
      if (( REPLY >= 1 && REPLY < ${#options[@]}  )); then
         DE=${options[REPLY-1]}
      elif (( REPLY == ${#options[@]} )); then
          echo "Goodbye!"
      else
          echo "Invalid option"
      fi
      break
  done
fi

if [[ -n "$TAG" ]]; then
  TAG_LINE="--tags $TAG"
fi
if [[ -n "$DE" ]]; then
  TAG_LINE="--tags main,$DE"
fi
if [[ -n "$LIST_DE" ]]; then
  echo -e "Available DE: \n$(list_de)"
  exit 0
fi

echo "Installing necessary packages"
sudo pacman -S --noconfirm --needed ansible-core xdg-user-dirs stow

#Should we download bw here?
# or should that be a different process?
# maybe an ansible role?
#

echo "Creating xdg directories"
xdg-user-dirs-update

echo "Installing collections"
ansible-galaxy install -r ansible/requirements.yml

echo "Installing system"
ansible-playbook ansible/main.yml --ask-become-pass $TAG_LINE $CHECK
