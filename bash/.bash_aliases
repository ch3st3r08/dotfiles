#Custom Aliases for bash

#Let us use user's defined aliases with sudo
alias sudo='sudo '

#Better LS
alias ls='exa --icons '
alias lsl='ls --long --group --header'
alias lsa='lsl --all'
alias lst='exa --tree --level=2 --group'

#cd up directory
alias ..='cd ..'
alias ...='cd ../..'
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias nv='nvim'
