#!/bin/bash

# ====================
# Environment
# ====================
export HOME=~

# ====================
# Path
# ====================
test -d "$HOME/bin" && PATH=$HOME/bin:$PATH
export PATH

# ====================
# Aliases
# ====================
if [[ $(uname) == 'Linux' ]]; then
  LS_COMMON="--color=auto"
elif [[ $(uname) == 'Darwin' ]]; then
  LS_COMMON="-Gh"
fi
test -n "$LS_COMMON" && alias ls="command ls $LS_COMMON"
alias ll="ls -l"
alias la="ls -la"

# ====================
# EDITOR and  PAGER
# ====================
EDITOR=vim
export EDITOR
PAGER="less -FiRsw"
MANPAGER=$PAGER
export PAGER MANPAGER

# ====================
# LS Colors
# ====================
export LSCOLORS=gxfxcxdxbxegedabagacad

# ====================
# PROMPT
# ====================
WHITE="\[\033[0;37m\]"
GREEN="\[\033[0;32m\]"
CYAN="\[\033[0;36m\]"
GRAY="\[\033[0;37m\]"
BLUE="\[\033[0;34m\]"
BLACK="\[\033[0;30m\]"
PURPLE="\[\033[0;35m\]"
RED="\[\033[0;31m\]"

prompt_simple() {
  unset PROMPT_COMMAND
  PS1="\W\$ "
  PS2="> "
}

function prompt_fancy {
  # Shows user@host in the title
  unset PROMPT_COMMAND
  TITLEBAR="\[\033]0;\u@\h\007\]"
  # Shows a "*" next to the branch name if you have un-staged local changes
  # Shows a "+" next to the branch name if you have staged local changes
  export GIT_PS1_SHOWDIRTYSTATE=1
  # Shows a "$" next to the branch name if you have stashed changes
  export GIT_PS1_SHOWSTASHSTATE=1
  # Shows a "%" next to the branch name if you have untracked files
  export GIT_PS1_SHOWUNTRACKEDFILES=1
  # Put it all together
  PS1="${TITLEBAR}${CYAN}\W${GREEN}"'$(__git_ps1 "(%s)")'"${WHITE}\$ "
  PS2="> "
}
prompt_fancy

# ====================
# Bash Completion
# ====================
if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi

