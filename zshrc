# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="nitish_robbyrussell_modified"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git web-search wd sudo python history zsh-autosuggestions) 

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LS_COLORS=$LS_COLORS"*.C=1;35:*.root=1;36:*.py=1;31"
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

alias ls='ls --color=auto -GFh'
alias ll='ls --color=auto -lGFh'
alias la='ls --color=auto -aGFh'
alias lla='ls --color=auto -alGFh'
alias du='du -kHh'
alias df='df -kHh'

#tmux
alias tmux='tmux -2'

#Kerberos
alias kinit='kinit -l 7d bnayak'

#ssh
alias ssh='ssh -X -Y'
alias sshgpu='ssh -X -Y nitish@128.200.48.165'
alias sshroc1='ssh -X -Y rocirvine1@128.200.48.171'
alias sshroc2='ssh -X -Y rocirvine2@128.200.48.169'
alias sshroc3='ssh -X -Y rocirvine3@128.200.48.164'

#syntax-highlighting
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#vim mode
source $ZSH_CUSTOM/plugins/zsh-vimto/zsh-vimto.zsh
export PYTHONPATH=~/Projects/NOvA/HDF5:$PYTHONPATH
export PYTHONPATH=/usr/local/opt/root/lib/root:$PYTHONPATH
