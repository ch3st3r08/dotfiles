#Apps default
export EDITOR='nvim'
export VISUAL='nvim'
export SUDO_EDITOR='nvim'

#Using zsh builtin way of managing PATH variable
typeset -U path
path=($HOME/.local/bin $HOME/Scripts $path)

#Apps config options
export STARSHIP_CONFIG=~/.config/starship/config.toml
#export NVM_DIR="$HOME/.nvm"

export ZIM_HOME="${ZDOTDIR}/.zim"
export OPENAI_API_KEY=$($HOME/Scripts/getSecret.sh openai)

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--height=50% --info=inline --border --margin=1 --padding=1"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_TMUX_OPTS='-p80%,60%'

export BUN_INSTALL="$HOME/.bun"
path=("$BUN_INSTALL/bin" $path)

export LIBVIRT_DEFAULT_URI="qemu:///system"
