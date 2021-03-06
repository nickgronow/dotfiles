# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alhF'
alias lsa="ls -alhF"
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias vim=nvim
alias ep="nvim ~/.bashrc"
alias em="nvim ~/.bash_aliases"
alias rp=". ~/.bashrc"

# Git
alias gitst="git st"

# Quick directories
NICK="$(realpath ~/me)"
alias cdp="cd $NICK/snippets"

# Pretty Path

alias path="tr ':' '\n' <<< $PATH"

# Cleanup files

cleanup() {
  find . -name '*.orig' -delete
  find . -name '*.swp' -delete
  find . -name '*.swo' -delete
}

# Vim

vimclean() {
  local path="/var/tmp/*${1:-*}*.sw*"
  rm $path
}

# FZF

# fh - repeat history
runcmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, <>' ; }

shist() {
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | runcmd
}

# fhe - repeat history edit
writecmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do{ chomp($_ = <>); $_ }' ; }

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# Interactive cd

function cd() {
  if [[ "$#" != 0 ]]; then
    builtin cd "$@";
    return
  fi
  while true; do
    local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
    local dir="$(printf '%s\n' "${lsd[@]}" |
      fzf --reverse --preview '
    __cd_nxt="$(echo {})";
    __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
    echo $__cd_path;
    echo;
    ls -p --color=always "${__cd_path}";
    ')"
    [[ ${#dir} != 0 ]] || return 0
    builtin cd "$dir" &> /dev/null
  done
}

# fasd & fzf change directory - open best matched file using `fasd` if given argument, filter output of `fasd` using `fzf` else
v() {
  [ $# -gt 0 ] && fasd -f -e ${EDITOR} "$*" && return
  local file
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vi "${file}" || return 1
}

# fasd & fzf change directory - jump using `fasd` if given argument, filter output of `fasd` using `fzf` else
unalias z
z() {
  [ $# -gt 0 ] && fasd_cd -d "$*" && return
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

# fs - Search for a snippet
sp() {
  local file
  file=$(find "$NICK/snippets" -printf "%f\n" 2> /dev/null | fzf +m) &&
  cat "$NICK/snippets/$file" | copyq add - && copyq select 0
}
spe() {
  local file
  file=$(find "$NICK/snippets" -printf "%f\n" 2> /dev/null | fzf +m)
  vim "$NICK/snippets/$file"
}
spr() {
  local file=$(find "$NICK/snippets" -printf "%f\n" 2> /dev/null | fzf +m)
  local cmd=$(cat "$NICK/snippets/$file")
  eval "$cmd"
}

# sc - Search clipboard
# sc() {
#   copyq eval -- "for(i=0; i<150; i++) print((str(read(i-1) || '').replace(/\n$/, '')) + '\n-------------------------------------------------------------------\n');" | vim -c ":set buftype=nofile" -
# }

# sr - Delete file
sr() {
  local files
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && rm "${files[@]}"
}


# Make snippet
new-snippet() {
  local file="$NICK/snippets/$1"
  local lastcmd="$(history | tail -n2 | head -n1 | cut -c 8-)"
  echo "$lastcmd" > "$file"
}
alias np="new-snippet"

# Copying recent commands
copy-last-command() {
  local cmd="$(history | tail -n2 | head -n1 | sed -re 's/^\s*[0-9]+\s*//')"
  copyq add "$cmd"
}
alias clc='copy-last-command'
alias cpq="copyq add - && copyq select 0"

# Bindings for fzf
bind '"\C-o": "sh\n"'

# File sizes

alias dud="du -h -d1 | sort -h | tac"

# Kubernetes

alias k="kubectl"

function krun() {
  local app=$1
  shift
  local container=$1
  shift
  local command=$@
  if [ -z $app ]; then
    printf "Must provide an app name\nWill be used as -l app=<name>\n"
    return 1
  fi
  local pod="$(kubectl get pods -l app=$app -o name | sed 's|pod/||' | head -n1)"
  if [ -z $pod ]; then
    echo "No pod found with a label of app=$1"
    return 1
  fi
  if [ -z $container ]; then
    $container=rails
  fi
  if [ -z "$command" ]; then
    $command=bash
  fi
  kubectl exec -it $pod -c $container $command
}
function krails() {
  krun $1 "${2-rails}" rails c
}
function kbash() {
  krun $1 "${2-rails}" bash
}
function klogs() {
  krun $1 "${2-rails}" logs --tail 100
}

# Docker & Docker-compose
dc="docker-compose"
dke="$dc exec app"

alias docker-remove-stopped-containers="docker ps -aq --no-trunc -f status=exited | xargs docker rm"

function docker-delete-images-by-name() {
  docker images | grep "$1" | tr -s ' ' | cut -d' ' -f1,2 | sed 's/ /:/' | xargs docker rmi
}

alias dkc="$dc"
alias dkr="$dc run app"
alias dke="$dc exec app"

# Rails & docker-compose
alias rs="$dke rails"
alias rk="$dke rake"
alias bi="$dke bundle"

# Less
alias less="less -R"

# Recent file
alias recent="ls -t | head -1"

# Change ownership of files to me
alias ownit="sudo chown -R $(whoami):$(whoami) ."

# Docker containers
alias py='docker run -it --rm -v "$PWD":/usr/src/app --network host --env TESTING=true python-cli python'

# Run snippets like a command
r() {
  if [ -z $1 ]; then
    printf "r [command]\n\nRun a bash script supplying the name of the script, without the file extension.  It must have execution permissions, and have a '.sh' file extension.\n\nExample: 'r test' will run the bash script located at '[SCRIPT_PATH]/test.sh'.\n"
    return
  fi
  local file="$NICK/scripts/$1.sh"
  if [ ! -f "$file" ]; then
    echo "$1 command was not found at: $file"
    return
  fi
  "$file"
}
re() {
  if [ -z $1 ]; then
    printf "re [command]\n\nEdit a command that the 'r' command runs."
    return
  fi
  local file="$NICK/scripts/$1.sh"
  if [ ! -f "$file" ]; then
    echo "$1 command was not found at: $file"
    return
  fi
  nvim "$file"
}

# Touchpad
alias enable-touchpad="gsettings set org.gnome.desktop.peripherals.touchpad send-events enabled"
alias disable-touchpad="gsettings set org.gnome.desktop.peripherals.touchpad send-events disabled"
alias enpad=enable-touchpad
alias dispad=disable-touchpad

# Open files
alias open="xdg-open"
