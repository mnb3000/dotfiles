#!/usr/bin/env bash
echo "Installing Neovim plugins.."
nvim --headless "+Lazy! install" +qa >/dev/null 2>&1
echo "Neovim plugins installed!"
