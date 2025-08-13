# Set up the prompt

autoload -Uz promptinit
promptinit
prompt off

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt appendhistory sharehistory hist_ignore_space
setopt hist_ignore_all_dups hist_save_no_dups hist_ignore_dups
setopt hist_find_no_dups extended_history
# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no

if [ "$TERM" = "linux" ]; then
  zstyle ':completion:*' menu select
else
  zstyle ':completion:*:git-checkout:*' sort false
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
  zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
  zstyle ':fzf-tab:*' popup-min-size 50 8
fi
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

bindkey "^[[H"  beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char

if [ "$TERM" != "linux" ]; then
   function set_win_title(){
       TERM_EMU=$(readlink "/proc/$(cat /proc/$(echo $$)/stat | cut -d ' ' -f 4)/exe")
       echo -ne "\033]0; $USER@$HOST: $(basename $PWD) - $(basename $TERM_EMU)  \007"
   }
   precmd_functions+=(set_win_title)
   eval "$(starship init zsh)"
   #neofetch --colors 12 7 12 12 7 7 --ascii_colors 4 7 7 7 7 7
fi

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
[[ -f $HOME/.config/wpg/sequences ]] && (cat ~/.config/wpg/sequences &)

#Load aliases
source "$ZDOTDIR/.zsh_aliases"

# zshenv path
# $ZDOTDIR/.zshenv

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# $ZDOTDIR/.zimrc
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules
source ${ZIM_HOME}/init.zsh

#Export and load Node Version Manager
[ -s "/usr/share/nvm/init-nvm.sh" ] && \. "/usr/share/nvm/init-nvm.sh"  # This loads nvm
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"  # This loads cargo

[ -s $(command -v zoxide) ] && eval "$(zoxide init zsh)"
[ -s $(command -v fzf) ] && eval "$(fzf --zsh)"


#PATH="$HOME/Sources/dart-sdk/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# bun completions
[ -s "/home/chester/.bun/_bun" ] && source "/home/chester/.bun/_bun"
[ -s $(command -v luarocks) ] && eval "$(luarocks path --bin)"
