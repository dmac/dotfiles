# Load common configuration
source ~/.shrc

# Vim navigation
set -o vi                                         # vi mode
bind -m vi-insert "\C-l":clear-screen             # Restore ^L to clear screen
bind -m vi-insert "\C-p":dynamic-complete-history # ^p check for partial match in history
bind -m vi-insert "\C-n":menu-complete            # cycle through the list of partial matches

# Colors
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS="ex=31:di=36:ln=35"

# Autocompletion
if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi

# Prompt
K="\e[0;30m\]"
R="\e[0;31m\]"
G="\e[0;32m\]"
Y="\e[0;33m\]"
B="\e[0;34m\]"
M="\e[0;35m\]"
C="\e[0;36m\]"
W="\e[0;38m\]"
NC="\e[0;0m\]"

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
  PS1="${TITLEBAR}${M}[\t] ${Y}[\u@\h] ${C}[\w]"
  # rvm status
  #[[ $(type -t rvm) = "function" ]] && PS1="${PS1} ${R}[\$(rvm current)]"
  # git status
  [[ $(type -t __git_ps1) = "function" ]] && PS1="${PS1} ${G}"'$(__git_ps1 "[%s]")'
  PS1="${PS1} \n${R}♥${NC}  "

  PS2="> "
}

prompt_fancy

# Load z. This must come after setting the prompt.
. ~/.dotfiles/scripts/z/z.sh
