#Custom Aliases for bash

#Better LS
alias ls='exa --long --icons'
alias lsa='exa --long --icons --all'
alias lst='exa --tree --level=2'

#cd up directory
alias ..='cd ..'
alias ...='cd ../..'
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias nv='nvim'
