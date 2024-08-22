#!/bin/bash

echo "Start: Im being called with argument $1"
old_filepath=$1
_path=$(dirname $old_filepath)
exten="${old_filepath##*.}"
tmux command-prompt -p "Enter new name:" "set-environment -g chester_new_filename '%%'"
new_name=$(tmux show-environment -g chester_new_filename | cut -d= -f2-)
cp --update $old_filepath "$_path/$new_name.$exten"
