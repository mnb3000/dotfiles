update-pacman-db() {
  pacman -Sy
}

upgrade-system() {
  pacman -Syyu
}

install-yay() {
  echo "Installing yay..."

  cd /tmp || exit
  sudo pacman --noconfirm -S --needed git base-devel
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin || exit
  makepkg --noconfirm -si
  cd ..
  rm -rf ./yay-bin

  echo "Successfully installed yay!"
}

setup-user() {
  useradd -G wheel -m "${USERNAME}"
  echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >>/etc/sudoers

  sudo -u "${USERNAME}" xdg-user-dirs-update
}

prebuild() {
  update-pacman-db

  sudo pacman --noconfirm -S git sudo shadow xdg-user-dirs

  setup-user
}

preinstall() {
  upgrade-system

  sudo pacman --noconfirm -S git python3
  install-yay
}
