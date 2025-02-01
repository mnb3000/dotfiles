#!/usr/bin/env bash

install-profile() {
  echo "Starting dotbot profile install..."
  "$HOME/.dotfiles/install-profile" "$1"
}

install() {
  echo "Starting profile install..."

  install-profile "$DOTBOT_PROFILE"
}

source ./scripts/functions.sh

check-env
source-distro "${DOTBOT_TARGET}"
preinstall
install
