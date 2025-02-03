function set-os-env-var {
  if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
  elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
  else
    OS="Unknown"
  fi
}

function is-macos {
  [[ "$OSTYPE" == darwin* ]] || return 1
}

function is-linux {
  [ "$(uname -s)" = "Linux" ] || return 1
}

function is-ubuntu {
  set-os-env-var
  [[ $OS =~ "Ubuntu" ]] || return 1
}

function is-debian {
  set-os-env-var
  [[ $OS =~ "Debian" ]] || return 1
}

function is-termux {
  [ "$(uname -m)" = "aarch64" ] && [[ "$(hostname)" =~ "localhost" ]] || return 1
}

function is-orangepi {
  [ "$(uname -m)" = "aarch64" ] && [[ "$(hostname)" =~ "orangepi" ]] || return 1
}

function is-deck {
  [ "$(uname -m)" = "amd64" ] || return 1
}

function is-ish {
  [[ -e "/etc/hostname" ]] && [[ "$(cat /etc/hostname)" =~ "ish" ]] || return 1
}

function is-arch {
  [[ -e "/etc/hostname" ]] && [[ "$(cat /etc/hostname)" =~ "arch" ]] || return 1
}

function src {
  [[ -n $_SHELL_DEBUG ]] && timestart=$($_date +%s%N)
  if [[ -f "$1" ]]; then
    source "$1"
  else
    if [[ -n $_SHELL_DEBUG ]]; then
      echo "Error src(): $1"
    fi
  fi
  [[ -n $_SHELL_DEBUG ]] && timeend=$($_date +%s%N)
  [[ -n $_SHELL_DEBUG ]] && echo -e "[$(($timeend - $timestart / 1000000))ms] src ${1}"
}

function eval-if-installed {
  if [[ "$(command -v "$2")" ]]; then
    eval "$1"
  fi
}

function src-if-installed {
  eval-if-installed "src $1" "$2"
}

# Find all matching processes
function p {
  ps -ef | grep -i "$1" | grep -v grep | grep --color -i "$1" # cursed but restores color highlighting
}

# Kill all matching processes
function ka {
  cnt=$(p "$1" | wc -l) # total count of processes found
  klevel=${2:-15}       # kill level, defaults to 15 if argument 2 is empty

  echo -e "\nSearching for '$1' -- Found" "$cnt" "Running Processes .. "
  p "$1"

  echo -e '\nTerminating' "$cnt" 'processes .. '

  ps aux | grep -i "$1" | grep -v grep | awk '{print $2}' | xargs kill -"$klevel"
  echo -e "Done!\n"

  echo "Running search again:"
  p "$1"
  echo -e "\n"
}
