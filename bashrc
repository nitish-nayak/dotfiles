#set aliases
export BASH_ENV=$HOME/.bash_aliases
source $BASH_ENV

#terminal colours
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1        
export LSCOLORS=DxFxBxDxCxegedabagacad

#root
if [ "$(uname)" == "Darwin" ]; then
    . $(brew --prefix root6)/libexec/thisroot.sh
fi

#rename multiple files
function supermv () {
        FILES="$2"
        PATTERN="$1"
        for i in $FILES; do N=$( echo "$i" | sed "$PATTERN" ); mv "$i" "$N"; done
}

# Make box around text @climagic
function box() { t="$1xxxx";c=${2:-=}; echo ${t//?/$c}; echo "$c $1 $c"; echo ${t//?/$c}; }
