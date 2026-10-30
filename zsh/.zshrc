# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode disabled
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Vars
export EDITOR="nvim"
export VISUAL="nvim"

# Go
export PATH="$HOME/go/bin:$PATH"

# Personal bin scripts
export PATH="$HOME/bin:$PATH"

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# Bash
autoload -U +X bashcompinit && bashcompinit

# Terraform
complete -o nospace -C terraform terraform

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

# Direnv
eval "$(direnv hook zsh)"

# Mise
eval "$(mise activate zsh)"

# Atuin
eval "$(atuin init zsh)"

# Aliases
alias ls="eza"
alias vim='nvim'
alias dotsync='mise -C "$HOME/Projects/dotfiles" run sync'
alias dotup='mise -C "$HOME/Projects/dotfiles" run upgrade'
