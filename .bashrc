#!/bin/bash

# ====================
# Environment
# ====================
export HOME=~
export TERM=xterm-256color

# Enable vi mode
set -o vi

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
PAGER="less -FiRswX"
MANPAGER=$PAGER
export PAGER MANPAGER

# ====================
# LS Colors
# ====================
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS="ex=31:di=36:ln=35"

# ====================
# Bash Completion
# ====================
if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi

# ====================
# PROMPT
# ====================
K="\[\033[0;30m\]"
R="\[\033[0;31m\]"
G="\[\033[0;32m\]"
Y="\[\033[0;33m\]"
B="\[\033[0;34m\]"
P="\[\033[0;35m\]"
C="\[\033[0;36m\]"
W="\[\033[0;38m\]"
NC="\[\033[0;0m\]"

function prompt_simple {
  unset PROMPT_COMMAND
  PS1="\W\\$ "
  PS2="> "
}

function prompt_fancy {
  unset PROMPT_COMMAND
  # Shows user@host in the title
  TITLEBAR="\[\033]0;\u@\h\007\]"
  # Shows a "*" next to the branch name if you have un-staged local changes
  # Shows a "+" next to the branch name if you have staged local changes
  export GIT_PS1_SHOWDIRTYSTATE=1
  # Shows a "$" next to the branch name if you have stashed changes
  export GIT_PS1_SHOWSTASHSTATE=1
  # Shows a "%" next to the branch name if you have untracked files
  export GIT_PS1_SHOWUNTRACKEDFILES=1

  # Put it all together
  PS1="${TITLEBAR}${P}[\t] ${Y}[\u@\h] ${C}[\w]"
  # rvm status
  #[[ $(type -t rvm) = "function" ]] && PS1="${PS1} ${R}[\$(rvm current)]"
  # git status
  [[ $(type -t __git_ps1) = "function" ]] && PS1="${PS1} ${G}"'$(__git_ps1 "[%s]")'
  PS1="${PS1} \n${R}♥${NC}  "

  PS2="> "
}

prompt_fancy
