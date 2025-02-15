alias zsh-prof="time ZSH_DEBUGRC=1 _DEBUG_SHELL=true zsh -i -c exit"

alias v="nvim"
alias ssh='TERM=xterm-256color ssh'

if is-macos; then
  [ -f $ZDOTDIR/custom/aliases.mac.zsh ] && source $ZDOTDIR/custom/aliases.mac.zsh
fi

if is-deck; then
  [ -f $ZDOTDIR/custom/aliases.deck.zsh ] && source $ZDOTDIR/custom/aliases.deck.zsh
fi

if is-debian || is-ubuntu; then
  [ -f $ZDOTDIR/custom/aliases.debian.zsh ] && source $ZDOTDIR/custom/aliases.debian.zsh
fi
