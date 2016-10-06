# Get readable output
alias ls='ls -GFh'
alias du='du -kH'
alias df='df -kH'

#Kerberos
alias kinit='kinit bnayak'

#root
if [ "$(uname)" == "Darwin" ]; then
    . $(brew --prefix root6)/libexec/thisroot.sh
fi
