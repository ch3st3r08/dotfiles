# Set up the prompt

autoload -Uz promptinit
promptinit
prompt off

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


export EDITOR='nvim'
export VISUAL='nvim'
export SUDO_EDITOR='nvim'
export RANGER_LOAD_DEFAULT_RC=false
export STARSHIP_CONFIG=~/.config/starship/config.toml

if [ "$TERM" != "linux" ]; then
   function set_win_title(){
       echo -ne "\033]0; $USER@$HOST  \007"
   }
   precmd_functions+=(set_win_title)
   eval "$(starship init zsh)"
   #neofetch --colors 12 7 12 12 7 7 --ascii_colors 4 7 7 7 7 7
fi

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
# [[ -f $HOME/.config/wpg/sequences ]] && (cat ~/.config/wpg/sequences &)

#Include user define bin directory
PATH="$HOME/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"

#Load rust stuff
source "$HOME/.cargo/env"

#Load aliases
source "$ZDOTDIR/.zsh_aliases"

#Load Plugins
source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh

#Export and load Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
