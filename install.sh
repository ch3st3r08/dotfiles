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

while getopts "ce:lt:vh" opt; do
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
    v)
      VERBOSE=1
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


if [[ -n "$TAG" ]]; then
  TAG_LINE="--tags $TAG"
fi
if [[ -n "$DE" ]]; then
  TAG_LINE="--tags main,$DE"
fi
if [[ -n "$LIST_DE" ]]; then
  _list=$(find . -type d -name "*_desktop" -exec basename {} \; \
    | sed 's/_desktop//')
  echo -e "Available DE: \n$_list"
  exit 0
fi

if [[ -z "$TAG_LINE" ]]; then
  my_error
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
