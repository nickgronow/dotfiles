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
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ep="vim ~/.bashrc"
alias em="vim ~/.bash_aliases"
alias ek="vim ~/.config/kitty/kitty.conf"
alias rp=". ~/.bashrc"
alias ei="vim ~/.config/i3/config"
alias set-title="kitty @ set-window-title"
alias vim="set-title nvim; nvim"
alias sudo="sudo "

alias lsa="ls -alhp"

# Git
alias gitst="git st"

# Useful cd tools
alias cdl='cd !!:$:h'
alias cdr='cd ~/.rbenv/versions/'

# Quick directories
NICK="/home/nick"
alias cdn="cd $NICK"
alias cdn="cd $NICK/notes"
alias cdd="cd $NICK/dotfiles"
alias cdp="cd $NICK/snippets"
alias cdo="cd $NICK/notes"
alias cdv="cd ~/.config/nvim"
alias cdd="cd ~/Downloads"
alias cdt="cd ~/tmp"

# Sites
SITES="$NICK/Sites"
alias cds="cd $SITES"
alias cdh="cd $SITES/homeward/www"
alias cdk="cd $SITES/datekeeper/html"
alias cdj="cd $SITES/johns/www/johns"

# Calculator

=() {
bc << EOF
  scale=4
  $@
  quit
EOF
}

# Global variables (through xdg runtime)
get-global-var() {
  if [ ! -f "${XDG_RUNTIME_DIR}/.$1" ]; then
    echo $2
  else
    var=$(cat "${XDG_RUNTIME_DIR}/.$1")
    echo ${var:-$2}
  fi
}
set-global-var() {
  printf "%s\n" $2 > "$XDG_RUNTIME_DIR/.$1"
}

# TODO: calculate spacing between answer and formula
calc() {
  local formula
  local answer
  echo -n "Answer: 0          Formula: "
  while IFS= read -r -s -n 1 char
  do
    # Enter key
    if [[ $char == $'\0' ]];     then
        break
    # Backspace key
    elif [[ $char == $'\177' ]];  then
        formula="${formula%?}"
    # Normal character
    else
        formula+="$char"
    fi
    answer="$(echo $formula | bc 2>/dev/null)"
    echo -ne "\rAnswer: $answer          Formula: $formula\033[K"
  done
  echo " "
  echo "$formula = $answer"
}

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

# cd - including hidden directories
sda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# cdf - cd into the directory of the selected file
sdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# fh - repeat history
runcmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, <>' ; }

shist() {
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | runcmd
}

# fhe - repeat history edit
writecmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do{ chomp($_ = <>); $_ }' ; }

she() {
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | writecmd
}

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

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
sfo() {
  local out file key
  IFS=$'\n' out=($(fzf --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
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

# Helpers for copying easily to clipboard
alias cpq="copyq copy -"

# fe - Search for an email
se() {
  copyq add "$(cat "$NICK/notes/contacts/emails.txt" | fzf +m)"
}

# fs - Search for a snippet
sp() {
  local file
  file=$(find "$NICK/snippets" -printf "%f\n" 2> /dev/null | fzf +m) &&
  cat "$NICK/snippets/$file" | copyq copy -
}
spe() {
  local file
  file=$(find "$NICK/snippets" -printf "%f\n" 2> /dev/null | fzf +m)
  vim "$NICK/snippets/$file"
}
spr() {
  local file=$(find "$NICK/snippets" -printf "%f\n" 2> /dev/null | fzf +m)
  local cmd=$(cat "$NICK/snippets/$file")
  echo "$cmd"
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


# Disk usage
alias dud="du -h -d1 | sort -h | tac"

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

# Bindings for fzf
bind '"\C-o": "sh\n"'

# Wellopp db connectivity
wellopp() {
  if [[ $@ == "start-db" ]]; then
    command ssh -f wellopp-db -N
  elif [[ $@ == "stop-db" ]]; then
    command kill $(ps aux | grep wellopp-db | head -n1 | tr -s " " | cut -d " " -f2)
  elif [[ $@ == "status-db" ]]; then
    command ps aux | grep wellopp-db | head -n1
  elif [[ $@ == "cloud" ]]; then
    command cloud_sql_proxy -instances homeward-ops:us-east4:wellopp-postgres=tcp:5450
  else
    echo 'sub command not found'
  fi
}

# Database connectivity
get-db-port() {
  current=$(get-global-var dbport)
  port=${current:-5000}
  next=$(($port+1))
  set-global-var dbport $next
  echo $next
}

db() {
  if [[ $1 == "gcs" ]]; then
    cloud_sql_proxy -dir /tmp/cloudsql
  elif [[ $1 == "wov" ]]; then
    kubectl port-forward --namespace default svc/harping-lambkin-postgresql $(get-db-port):5432
  elif [[ $# != 2 ]]; then
    echo "You need to supply {database-name} {start|stop|status}"
  elif [[ $2 == "start" ]]; then
    ssh -f "$1-db" -N
  elif [[ $2 == "stop" ]]; then
    kill $(ps aux | grep "$1-db" | sed '/grep/d' | head -n1 | tr -s " " | cut -d " " -f2)
  elif [[ $2 == "status" ]]; then
    ps aux | grep "$1-db" | head -n1
  elif [[ $2 == "cloud" ]]; then
    cloud_sql_proxy -instances "homeward-ops:us-central1:$1=tcp:$(get-db-port)"
  else
    echo 'sub command not found'
  fi
}

# Wellopp psql connect
psql() {
  set-title psql
  if [[ $@ =~ ^(cp|sb)(prod|qa)$ ]]; then
    port="$(get-port-for $@)"
    command psql -h localhost -p "$port" -U $@ $@
  elif [[ $@ =~ ^dispatch-prod$ ]]; then
    port="$(get-port-for $@)"
    command psql -h localhost -p "$port" -U postgres dispatch
  elif [ $@ == dashboard ]; then
    command psql -h localhost -p 5486 -U dashboard dashboard
  elif [[ $@ =~ ^dispatch-qa$ ]]; then
    port="$(get-port-for $@)"
    command psql -h localhost -p "$port" -U postgres dispatch
  elif [[ $@ == 'lighthouse' ]]; then
    port="$(get-port-for wov)"
    command psql -h localhost -p "$port" -U postgres lighthouse
  elif [[ $@ == 'cth' ]]; then
    port="$(get-port-for wov)"
    command psql -h localhost -p "$port" -U cthdb cthdb
  elif [[ $@ == "jnprod" ]]; then
    command psql -h localhost -p 5452 -U johns
  elif [[ $@ == 'lhl' ]]; then
    command psql -h localhost -p 5482 -U postgres lhl
  elif [[ $@ == "mce" ]]; then
    command psql -h localhost -p 5484 -U postgres mce
  elif [[ $@ == "cth" ]]; then
    command psql -h localhost -p 5485 -U postgres cth
  elif [[ $@ == "mce-prod" ]]; then
    port="$(get-port-for wov)"
    command psql -h localhost -p "$port" -U mce mce
  elif [[ $@ == "wov" ]]; then
    port="$(get-port-for wov)"
    command psql -h localhost -p "$port" -U postgres postgres
  else
    command psql -h localhost "$@"
  fi
}

# Redis server
alias redis-start='redis-server /etc/redis.conf &'
alias redis-stop='kill $(ps aux | grep redis-server | head -n1 | tr -s " " | cut -d " " -f2)'

# AG

alias ag='ag --smart-case --pager="less -MIRFX"'

# File sizes

alias dud="du -h -d1 | sort -h | tac"

# Calendar

alias gcal="google-chrome --new-window calendar.google.com && exit"

# SSH

ssh-wellopp-key() {
  cat "$NICK/snippets/homeward ssh key.txt" | copyq copy - > /dev/null
  ssh-add ~/.ssh/wellopp
}

# Kubernetes

alias k="kubectl"

# Zoom

alias zoom="QT_AUTO_SCREEN_SCALE_FACTOR=2 zoom"

# Clementine

alias clementine="QT_AUTO_SCREEN_SCALE_FACTOR=2 clementine"

# Pandoc

alias pandoc-to-html="pandoc -F mermaid-filter -s -c ~/.config/pandoc/markdown.css"

# Rails
alias rs="docker-compose exec web rails"
alias rk="docker-compose exec web rake"
alias bi="docker-compose exec web bundle install"
alias rc="docker-compose exec web rspec"

# Docker & Docker-compose

alias dkc="docker-compose"
alias dkr="docker-compose run web"
alias dke="docker-compose exec web"
alias docker-remove-stopped-containers="docker ps -aq --no-trunc -f status=exited | xargs docker rm"

# SSH

alias ssh="kitty +kitten ssh"

# Less
alias less="less -R"

# Recent file
alias recent="ls -t | head -1"

# Change ownership of files to me
alias ownit="sudo chown -R nick:nick ."

# Battery
alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage"

# FEH
alias feh="feh --theme clean"

# Open-faas
alias faas-connect="kubectl port-forward svc/gateway -n openfaas 31112:8080"

# Local npm binaries
npr() {
  "node_modules/.bin/$1"
}
