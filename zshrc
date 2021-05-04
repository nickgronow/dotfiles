# General
bindkey -v

# My binaries
path=("$HOME/bin" $path)

# rbenv
path=("$HOME/.rbenv/bin" $path)
eval "$(rbenv init -)"

# History Settings
export HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
export SAVEHIST=5000
export HISTSIZE=2000
setopt share_history
setopt append_history
setopt hist_ignore_dups
setopt hist_reduce_blanks

# LS
alias ll='ls -alhFG'

# FASD
eval "$(fasd --init auto)"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Vim
alias vim=nvim
alias ep="vim ~/dotfiles/zshrc"
alias rp="source ~/dotfiles/zshrc"

# Docker
alias dkc=docker-compose

# Git
alias gitst="git st"

# GNU sed - brew install gnu-sed
path=("/usr/local/opt/gnu-sed/libexec/gnubin" $path)

# GNU find - brew install findutils
path=("/usr/local/opt/findutils/libexec/gnubin" $path)

# Rails
alias rs=bin/rails
alias rk=bin/rake

# File house-keeping
cleanup() {
  local files="$(find . -name '*.orig')"
  if [[ -z $files ]]; then
    echo "Already neat and tidy"
  else
    find . -name '*.orig' -printf '%p\n' -delete
    echo "The above files were removed successfully"
  fi
}

# iTerm2 Shell Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

# Imagemagick
path=("/usr/local/opt/imagemagick@6/bin" $path)
