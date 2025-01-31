#!/usr/bin/env bash
sudo pacman --noconfirm -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin || exit
makepkg --noconfirm -si
cd ..
rm -rf ./yay-bin
