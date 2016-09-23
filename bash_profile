export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


stty start undef stop undef

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'

#root
. $(brew --prefix root6)/libexec/thisroot.sh

