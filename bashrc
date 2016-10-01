# Get readable output
alias ls='ls -GFh'
alias du='du -kH'
alias df='df -kH'

#root
if [ "$(uname)" == "Darwin" ]; then
    . $(brew --prefix root6)/libexec/thisroot.sh
fi
