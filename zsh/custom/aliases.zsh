alias zsh-prof="time ZSH_DEBUGRC=1 zsh -i -c exit"

alias lg="lazygit"

alias v="nvim"
alias ssh='TERM=xterm-256color ssh'

if is-macos; then
  [ -f $ZDOTDIR/custom/aliases.deck.zsh ] && source $ZDOTDIR/custom/aliases.mac.zsh
fi

if is-deck; then
  [ -f $ZDOTDIR/custom/aliases.deck.zsh ] && source $ZDOTDIR/custom/aliases.deck.zsh
fi
