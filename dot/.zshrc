#                      /$$
#                     | $$
#  /$$$$$$$$  /$$$$$$$| $$$$$$$   /$$$$$$   /$$$$$$$
# |____ /$$/ /$$_____/| $$__  $$ /$$__  $$ /$$_____/
#    /$$$$/ |  $$$$$$ | $$  \ $$| $$  \__/| $$
#   /$$__/   \____  $$| $$  | $$| $$      | $$
#  /$$$$$$$$ /$$$$$$$/| $$  | $$| $$      |  $$$$$$$
# |________/|_______/ |__/  |__/|__/       \_______/

# Set vim bindings
bindkey -v
setopt promptsubst

# PROMPT SECTION
function pwd_tilde {
    if [[ "${PWD#$HOME}" != "$PWD" ]] then
        echo "~${PWD#$HOME}"
    else
        echo "$PWD"
    fi
}

function ssh_host {
    if [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]; then
        echo -n "($HOST) "
    else
        echo -n
    fi
}

function tar_dir {
        tar -czf $1.gz $1;
}

local dir='$(pwd_tilde)'
local day_time='$(date +%R)'
local host_name='$(ssh_host)'

# prints like this: [21:01] ~/repos $
# prints like this when in SSH: (t460s) [21:01] ~/repos $
export PS1="$host_name""[%{$(printf '\e[31m')%}$day_time%{$(printf '\e[0m')%}] %{$(printf '\e[34m')%}""$dir
""%{$(printf '\e[32m')%}$""%{$(printf '\e[0m')%} ";

export PATH="$PATH:/home/jhiggins/.local/share/coursier/bin:$HOME/go/bin"
export GOPATH="$HOME/go/"

if [[ -f ~/.env ]]; then
    source ~/.env
fi

if [[ -f ~/.alias ]]; then
    source ~/.alias
fi

if test -f "$(which pokemonsay)" && test -f "$(which fortune)"; then
    fortune | pokemonsay --pokemon Rhydon --no-name
fi

# Created by `pipx` on 2024-07-20 04:22:25
export PATH="$PATH:/Users/jhiggins/.local/bin:$HOME/scripts/:$HOME/.scripts/"

if [[ -f ~/.zfunc ]]; then
    fpath+=~/.zfunc
    autoload -Uz compinit && compinit
fi

. "$HOME/.local/bin/env"

source $HOME/.local/bin/env

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# fnm
FNM_PATH="/home/jhiggins/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/jhiggins/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

export OLDPWD=$(test -f ~/.oldpwd && cat ~/.oldpwd);
function __oldpwdcd {
    if test -d "$1"; then
        \cd $@;
        echo $( realpath "$1" ) > $HOME/.oldpwd;
    elif [ "-" = "$1" ]; then
        \cd $OLDPWD;
    else
        \cd $@;
    fi
}
alias cd='__oldpwdcd';

function zshaddhistory() {
  emulate -L zsh
  if ! [[ "$1" =~ "(--password|history)" ]] ; then
      print -sr -- "${1%%$'\n'}"
      fc -p
  else
      return 1
  fi
}

export TERM="xterm-256color";
export PATH=$PATH:/usr/local/go/bin

if which wal > /dev/null; then
    filepath=$(gsettings get org.gnome.desktop.background picture-uri-dark)
    fileuri=$(echo $filepath | awk -F "'" '{print $2}' | awk -F '://' '{print $2}')
    test -z $fileuri || wal -i $fileuri >> /dev/null
fi
