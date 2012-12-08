# Load common configuration
source ~/.shrc

# History
setopt INC_APPEND_HISTORY # save history as commands are entered, not when shell exits
setopt HIST_IGNORE_DUPS   # don't save duplicate commmands in history
setopt HIST_IGNORE_SPACE  # don't save commands that begin with a space

# Miscellaneous options
setopt AUTO_CD                        # cd if no command and directory present
export PROMPT_EOL_MARK="%F{red}↵%f" # no EOL mark

# Colors
dircolors > /dev/null 2>&1 && eval $(dircolors)
gdircolors > /dev/null 2>&1 && eval $(gdircolors)

# fpath
[[ -d ~/.zsh/functions ]] && fpath=( ~/.zsh/functions $fpath)

# Autocompletion
autoload -U compinit && compinit

# Case-insensitive, partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:*:*' menu select
# Cache completions
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zcache
# Completion colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# Fuzzy completion matching
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Edit command line with v in normal mode
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

# Git information on prompt
autoload -Uz vcs_info

# Additional vcs_info hooks
function +vi-git-untracked() {
  if git status --porcelain | grep '??' > /dev/null 2>&1 ; then
    hook_com[unstaged]+='%F{red}●'
  fi
}
function +vi-git-stash() {
if [[ $(git stash list) != "" ]]; then
  hook_com[unstaged]+='%F{white}●'
  fi
}

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' formats '%F{green}[%b%c%u%F{green}]'
zstyle ':vcs_info:*' actionformats '%F{green}[%a|%b%c%u%F{green}]'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-stash
setopt prompt_subst

# Prompt
PROMPT='%F{magenta}[%*] %F{yellow}[%n@%m] %F{cyan}[%~] ${vcs_info_msg_0_}
%F{red}♥%f  '
RPROMPT="\`if [ \$? != 0 ]; then echo \"%F{red}!%f\"; fi\`"

# Vim key bindings
bindkey -v
bindkey "^?" backward-delete-char                # vi-backward-delete-char
bindkey '^R' history-incremental-search-backward # search backwards with ^R
bindkey '^[[Z' reverse-menu-complete             # backwards completion with shift-tab

# Aliases
alias src="source ~/.zshrc; source ~/.zprofile"

function precmd()
{
  vcs_info             # git info
  _z --add "$(pwd -P)" # z.sh
}

# Source plugins
source ~/sources/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
