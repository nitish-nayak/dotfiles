#set aliases
export BASH_ENV=$HOME/.bash_aliases
source $BASH_ENV

#terminal colours
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1        
export LSCOLORS=ExFxBxDxCxegedabagacad

#root
if [ "$(uname)" == "Darwin" ]; then
    . $(brew --prefix root6)/libexec/thisroot.sh
fi
