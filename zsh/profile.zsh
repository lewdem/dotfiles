source ~/.config/zsh/env.zsh

HISTFILE=~/.config/zsh/history
HISTSIZE=10000
SAVEHIST=5000
PATH=$PATH:~/.cargo/bin:~/Scripts

alias hx='helix'
alias ls='lsd'
alias cat='bat'
alias tree='ls --tree'
alias py='python'
alias get-token='echo $GIT_TOKEN | wl-copy'

function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}

function xplr() {
    dir=$( /bin/xplr $1)
    
    if [ -f $dir ]; then
        if test -z "$dir" 
        then
            dir=$(pwd)
        else
            dir=$(dirname $dir)
        fi
    fi
    cd $dir
}

autoload -Uz add-zsh-hook
add-zsh-hook -Uz chpwd chpwd-osc7-pwd
