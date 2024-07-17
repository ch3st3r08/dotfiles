# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

#Apps default
export EDITOR='nvim'
export VISUAL='nvim'
export SUDO_EDITOR='nvim'

#Include user define bin directory
PATH="$HOME/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"

#Apps config options
export RANGER_LOAD_DEFAULT_RC=false
export STARSHIP_CONFIG=~/.config/starship/config.toml
export NVM_DIR="$HOME/.nvm"

export ZIM_HOME="${ZDOTDIR}/.zim"
export OPENAI_API_KEY=$($HOME/.dotfiles/bin/bin/getSecret.sh openai)
#export ADOTDIR="${ZDOTDIR}/antigen"

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--height=60% --info=inline --border --margin=1 --padding=1"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_TMUX_OPTS='-p80%,60%'
