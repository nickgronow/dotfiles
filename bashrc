# Profiling
# PS4='+ $(date "+%s.%N")\011 '
# exec 3>&2 2>/tmp/bashstart.$$.log
# set -x

# Pip installs commands to the .local/bin directory
PATH="$HOME/.local/bin:$PATH"

# NPM
# PATH="$PATH:$HOME/.npm/bin"

# Node
# export N_PREFIX="$HOME/.n"
# export PATH="${N_PREFIX}/bin:${PATH}"

# Set term to a more standard value
# export TERM=xterm-256color

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=10000
export HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Default editors
set -o vi
export EDITOR='vim'
export VISUAL='vim'

#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

# Locales
export LC_CTYPE='en_US.UTF-8'

# ==============
# Command Prompt
# ==============

# Save current working dir
# PROMPT_COMMAND='pwd > "${XDG_RUNTIME_DIR}/.cwd"'

# Display host and current directory
PS1='\[\033[01;32m\]\h\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\] \$ '

# Prompt directories
PROMPT_DIRTRIM=1

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# ================
# Git bash prompt
# ================

# https://github.com/magicmonty/bash-git-prompt
GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_FETCH_REMOTE_STATUS=1 # fetch remote status
GIT_PROMPT_SHOW_UPSTREAM= # show upstream tracking branch
GIT_PROMPT_SHOW_UNTRACKED_FILES=all # can be no, normal or all; determines counting of untracked files
GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=1 # print the number of changed files
GIT_PROMPT_THEME=Default_Ubuntu
if brew -v &> /dev/null; then
  if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
    GIT_PROMPT_ONLY_IN_REPO=1
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
  fi
else
  source ~/.bash-git-prompt/gitprompt.sh
fi

# ================
#       FZF
# ================

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Colors
export FZF_DEFAULT_OPTS='
  --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
  --color info:150,prompt:110,spinner:150,pointer:167,marker:174
'

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='**'

# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'

# Use ripgrep
export FZF_DEFAULT_COMMAND='rg'

# Append history instead of overwrite
shopt -s histappend

# Append commands immediately instead of when terminal is closed
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Kubernetes

# Personal bin executables
export PATH=~/bin:$PATH

# Ripgrep
export RIPGREP_CONFIG_PATH=~/.config/ripgrep/ripgreprc

# FASD
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Bash completions

if [ -f ~/.bash_completions ]; then
  . ~/.bash_completions
fi

# Device-specific configurations we do not store in source control

if [ -f ~/.bash_custom ]; then
  . ~/.bash_custom
fi

if command -v kubectl &> /dev/null
then
  export PATH=~/.kubectx:$PATH
  source <(kubectl completion bash)
  alias k=kubectl
  complete -F __start_kubectl k
fi

export PAGER=less

if [ -f ~/.bash_docker ]; then
    source ~/.bash_docker
fi

# Use neovim
alias vim="nvim"

# pip - make 3 the defualt
alias pip=pip3

# gcloud
export CLOUDSDK_PYTHON=/usr/bin/python

# pyenv
export PATH="/home/nick/.pyenv/bin:$PATH"
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
else
    alias python=python3
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if command -v yarn &> /dev/null; then
    export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi
