export ZOXIDE_CMD_OVERRIDE=cd

if (( $+commands[zoxide] )); then
  eval "$(zoxide init --cmd ${ZOXIDE_CMD_OVERRIDE:-z} zsh)"
else
  echo 'zoxide not found, please install it from https://github.com/ajeetdsouza/zoxide'
fi
