# Antidote plugin loading
local zplugins=${ZDOTDIR:-$HOME/.zsh}/.zplugins

if is-i686
then
  src $ZDOTDIR/custom/plugins.omz.zsh
else
  src $ZDOTDIR/custom/plugins.antidote.zsh
fi
