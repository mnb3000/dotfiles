if [[ "$(cat /etc/hostname)" =~ "arch" ]]; then
  unset $LANG
  source /etc/profile.d/locale.sh
fi
