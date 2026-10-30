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
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

# Zig
export PATH="$HOME/.zvm/bin:$PATH"

# Direnv
eval "$(direnv hook zsh)"

# fnm: Fast Node Manager
eval "$(fnm env)"

# Ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Atuin
eval "$(atuin init zsh)"

# Aliases
alias ff="$HOME/bin/ff"
alias fg="$HOME/bin/fg"
alias ls="eza"
alias vim='nvim'
