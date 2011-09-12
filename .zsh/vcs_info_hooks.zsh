function +vi-git-untracked()
{
  if git status --porcelain | grep '??' > /dev/null 2>&1 ; then
    hook_com[unstaged]+='%F{red}●'
  fi
}

function +vi-git-stash()
{
  if [[ $(git stash list) != "" ]]; then
    hook_com[unstaged]+='%F{white}●'
  fi
}

