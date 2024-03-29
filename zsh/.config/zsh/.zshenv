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
