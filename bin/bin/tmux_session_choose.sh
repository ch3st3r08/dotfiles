#!/bin/sh

session_dir=~/.local/share/tmux/resurrect
cd $session_dir
filename=$(fd --exclude last | fzf --tmux)
if [[ ! -z $filename ]]; then
    ln -sf $filename last
fi
