source ~/.dotfiles/scripts/z/z.sh
function precmd()
{
  _z --add "$(pwd -P)"
}
