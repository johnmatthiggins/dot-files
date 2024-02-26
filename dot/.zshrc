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

local dir='$(pwd_tilde)'
local day_time='$(date +%R)'
local host_name='$(ssh_host)'

# prints like this: [21:01] ~/repos $
# prints like this when in SSH: (t460s) [21:01] ~/repos $
export PS1="$host_name""[%{$(printf '\e[31m')%}$day_time%{$(printf '\e[0m')%}] %{$(printf '\e[34m')%}""$dir
""%{$(printf '\e[32m')%}~>""%{$(printf '\e[0m')%} ";

export PATH="$PATH:/home/jhiggins/.local/share/coursier/bin:$HOME/go/bin"
export GOPATH="$HOME/go/"

if [[ -f ~/.env ]]; then
    source ~/.env
fi

if [[ -f ~/.alias ]]; then
    source ~/.alias
fi
