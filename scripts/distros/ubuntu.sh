update-apt-db() {
  apt-get clean
  apt-get update
}

upgrade-system() {
  sudo apt-get clean
  sudo apt-get update
  sudo apt-get -y upgrade
}

setup-login-user() {
  useradd -G sudo -m "${USERNAME}"
  sudo -u "${USERNAME}" xdg-user-dirs-update
  echo "%sudo ALL=(ALL:ALL) NOPASSWD: ALL" >>/etc/sudoers
}

prebuild() {
  update-apt-db

  apt-get install -y sudo git xdg-user-dirs
  setup-login-user
}

preinstall() {
  upgrade-system

  sudo apt-get install -y python3 python-is-python3
}
