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

# Keep secrets out of zsh history. Return 2 keeps a command in session memory only.
_zsh_history_secret_filter() {
  emulate -L zsh
  setopt extended_glob
  local cmd="${1%%$'\n'}"
  local -a patterns=(
    '(#i)*TOKEN=*'
    '(#i)*API_KEY=*'
    '(#i)*API_SECRET=*'
    '(#i)*SECRET_KEY=*'
    '(#i)*_SECRET=*'
    '(#i)*PASSWORD=*'
    '(#i)*PASSWD=*'
    '(#i)*_PASS=*'
    '(#i)*AWS_SECRET_ACCESS_KEY=*'
    '(#i)*PRIVATE_KEY=*'
    '(#i)*Authorization:*'
    '(#i)*Bearer *'
    '(#i)* --password *'
    '(#i)*ghp_*'
    '(#i)*glpat-*'
  )
  for pat in "${patterns[@]}"; do
    if [[ "$cmd" == ${~pat} ]]; then
      return 2
    fi
  done
  return 0
}
autoload -Uz add-zsh-hook
add-zsh-hook zshaddhistory _zsh_history_secret_filter

# Atuin
eval "$(atuin init zsh)"

# Aliases
alias ls="eza"
alias vim='nvim'
alias dotsync='mise -C "$HOME/Projects/dotfiles" run sync'
alias dotup='mise -C "$HOME/Projects/dotfiles" run upgrade'
