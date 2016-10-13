# Get readable output
alias ls='ls -GFh'
alias ll='ls -lGFh'
alias la='ls -aGFh'
alias lla='ls -alGFh'
alias du='du -kHh'
alias df='df -kHh'

#Kerberos
alias kinit='kinit -l 7d bnayak'

#root
if [ "$(uname)" == "Darwin" ]; then
    . $(brew --prefix root6)/libexec/thisroot.sh
fi
