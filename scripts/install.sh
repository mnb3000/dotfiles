#!/usr/bin/env bash
check-env() {
  if [[ ! $DOTBOT_PROFILE ]]; then
    echo "\$DOTBOT_PROFILE must be set"
    return 1
  fi
}

update-pacman-db() {
  pacman -Sy
}

install-yay() {
  echo "Installing yay..."
  bash ./scripts/install-yay.sh
  echo "Successfully installed yay!"
}

preinstall() {
  update-pacman-db
  install-yay
}

install-profile() {
  echo "Starting dotbot profile install..."
  bash ./install-profile "$1"
}

install() {
  echo "Starting profile install..."

  install-profile "$DOTBOT_PROFILE"
}

check-env
preinstall
install
