check-env() {
  if [[ ! $DOTBOT_PROFILE ]]; then
    echo "\$DOTBOT_PROFILE must be set"
    exit
    # return 1
  fi
  if [[ ! $DOTBOT_TARGET ]]; then
    echo "\$DOTBOT_TARGET must be set"
    return 1
  fi
}

source-distro() {
  source "./scripts/distros/$1.sh"
}
