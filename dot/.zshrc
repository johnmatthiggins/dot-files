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

if [[ "$(uname)" == "Darwin" ]] then
    PS1="[$(whoami)@$(hostname) "'$(pwd_tilde)'"]$ "
else
    PS1="[$(printf '\e[32m')$(whoami)@$(hostname)$(printf '\e[0m') $(printf '\e[34m')""$(pwd_tilde)""$(printf '\e[0m')]$ "
fi

export MAN_POSIXLY_CORRECT=1

if [[ -f ~/.env ]]; then
    source ~/.env
fi

if [[ -f ~/.alias ]]; then
    source ~/.alias
fi
