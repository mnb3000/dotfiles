update-apt-db() {
  apt-get update
}

upgrade-system() {
  sudo apt-get clean
  sudo apt-get update
  sudo apt-get -y upgrade
}

setup-login-user() {
  setup-user -a "${USERNAME}"
  sudo -u "${USERNAME}" xdg-user-dirs-update
  echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >>/etc/sudoers
}

prebuild() {
  update-apt-db

  apt-get install bash shadow sudo git xdg-user-dirs
  setup-login-user
}

preinstall() {
  upgrade-system
  bash

  sudo apt-get install git python3 python-is-python3

}
