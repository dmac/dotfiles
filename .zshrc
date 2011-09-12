autoload -U compinit && compinit # Autocompletion

# Path
[[ -d ~/bin ]] && export PATH=~/bin:$PATH

# Git information on prompt
autoload -Uz vcs_info
source ~/.zsh/vcs_info_hooks.zsh
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' formats '%F{green}[%b%c%u%F{green}]'
zstyle ':vcs_info:*' actionformats '%F{green}[%a|%b%c%u%F{green}]'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-stash
setopt prompt_subst

# Function files
[[ -d ~/.zsh/functions ]] && fpath=( ~/.zsh/functions $fpath)

# Prompt
PROMPT='%F{magenta}[%*] %F{yellow}[%n@%m] %F{cyan}[%~] ${vcs_info_msg_0_}
%F{red}♥%f  '
PROMPT2=" > "

# Vim key bindings
bindkey -v
bindkey "^?" backward-delete-char                # vi-backward-delete-char
bindkey '^R' history-incremental-search-backward # search backwards with ^R
bindkey '^[[Z' reverse-menu-complete             # backwards completion with shift-tab

# Aliases
alias ls="ls -G"
alias ll="ls -Gl"
alias la="ls -Gla"
alias g="git"
alias gh="ghci"
#
# Configure z.sh
source ~/.dotfiles/scripts/z/z.sh
function precmd()
{
  vcs_info
  _z --add "$(pwd -P)"
}
