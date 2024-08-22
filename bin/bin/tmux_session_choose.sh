#!/bin/sh

SESSION_DIR=~/.local/share/tmux/resurrect
RESURRECT_DIR=~/.config/tmux/plugins/tmux-resurrect
cd $SESSION_DIR
filename=$(fd --exclude last | fzf --tmux)
if [[ ! -z $filename ]]; then
    ln -sf $filename last
    tmux run-shell "$RESURRECT_DIR/scripts/restore.sh"
fi
