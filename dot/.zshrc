# set vim bindings
bindkey -v

# PROMPT SECTION
function pwd_tilde {
    if [[ "${PWD#$HOME}" != "$PWD" ]] then
        echo "~${PWD#$HOME}"
    else
        echo "$PWD"
    fi
}

setopt promptsubst
local dir='$(pwd_tilde)'

if [[ "$(uname)" == "Darwin" ]] then
    PS1="[$(whoami)@$(hostname) $dir]$ "
else
    PS1="[$(printf '\e[32m')$(whoami)@$(hostname)$(printf '\e[0m') $(printf '\e[34m')""$dir""$(printf '\e[0m')]$ "
fi

export MAN_POSIXLY_CORRECT=1

if [[ -f ~/.env ]]; then
    source ~/.env
fi

if [[ -f ~/.alias ]]; then
    source ~/.alias
fi
