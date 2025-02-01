update-apk-db() {
  apk update
}

upgrade-system() {
  sudo apk update
  sudo apk upgrade
}

setup-login-user() {
  setup-user -a "${USERNAME}"
  sudo -u "${USERNAME}" xdg-user-dirs-update
  echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >>/etc/sudoers
}

prebuild() {
  update-apk-db

  apk --no-cache add bash shadow sudo git alpine-conf xdg-user-dirs
  setup-login-user
}

preinstall() {
  upgrade-system
  bash

  sudo apk --no-cache add git python3
}
