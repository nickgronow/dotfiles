# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias lsa="ls -alhp"
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
alias rp=". ~/.bashrc"

# Git
alias gitst="git st"

# Useful cd tools
alias cdl='cd !!:$:h'
alias cdr='cd ~/.rbenv/versions/'

# Quick directories
NICK="$(realpath ~)"
alias cdn="cd $NICK"
alias cdd="cd $NICK/dotfiles"
alias cdp="cd $NICK/snippets"
alias cdd="cd ~/Downloads"
alias cdt="cd ~/tmp"

# Sites
SITES="$NICK/Sites"
alias cds="cd $SITES"

# Calculator

=() {
bc << EOF
  scale=4
  $@
  quit
EOF
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

# Wellopp psql connect
# psql() {
#   if [[ $@ =~ ^(a|b)(c|d)$ ]]; then
#     psql -h localhost -p "$port" -U $@ $@
#   elif [[ $@ == "text" ]]; then
#     psql -h localhost -p "$port" -U mce mce
#   else
#     psql -h localhost "$@"
#   fi
# }

# File sizes

alias dud="du -h -d1 | sort -h | tac"

# Kubernetes

alias k="kubectl"

# Rails
alias rs="docker-compose exec web rails"
alias rk="docker-compose exec web rake"
alias bi="docker-compose exec web bundle install"
alias rc="docker-compose exec web rspec"

# Docker & Docker-compose

alias dkc="docker-compose"
alias dkr="docker-compose run app"
alias dke="docker-compose exec app"
alias docker-remove-stopped-containers="docker ps -aq --no-trunc -f status=exited | xargs docker rm"

# Less
alias less="less -R"

# Recent file
alias recent="ls -t | head -1"

# Change ownership of files to me
alias ownit="sudo chown -R nick:nick ."

# FEH
alias feh="feh --theme clean"
