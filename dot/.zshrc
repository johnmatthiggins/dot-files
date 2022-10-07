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

local dir='$(pwd_tilde)'
local day_time='$(date +%R)'

if [[ "$(uname)" == "Darwin" ]] then
    PS1="[$day_time$] ""$dir"" ""$ "
else
    PS1="[%{$(printf '\e[31m')%}$day_time%{$(printf '\e[0m')%}] %{$(printf '\e[34m')%}""$dir"" %{$(printf '\e[32m')%}$""%{$(printf '\e[0m')%} ";
fi

if [[ -f ~/.env ]]; then
    source ~/.env
fi

if [[ -f ~/.alias ]]; then
    source ~/.alias
fi
