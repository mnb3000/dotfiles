function is-macos {
  [[ "$OSTYPE" == darwin* ]] || return 1
}

function is-termux {
  [ "$( uname -s )" = "Linux" ] && [ "$( uname -m )" = "aarch64" ]  || return 1
}

function is-deck {
  [ "$( uname -s )" = "Linux" ] && [ "$( uname -m )" = "aarch64" ]  || return 1
}
