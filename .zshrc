# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' frequency 30
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Go
export PATH="$HOME/go/bin:$PATH"

# Personal bin scripts
export PATH="$HOME/bin:$PATH"

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"
. "/Users/johnmayou/.deno/env"

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

# Aliases
alias fg="$HOME/bin/fg"
alias ff="$HOME/bin/ff"
alias ls="eza"
alias cat='bat --paging=never'
alias vim='nvim'
