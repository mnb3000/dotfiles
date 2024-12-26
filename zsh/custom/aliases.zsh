alias zsh-prof="time ZSH_DEBUGRC=1 zsh -i -c exit"

eza_params_no_git=('--icons' '--color=always' '--group-directories-first')
eza_params=('--git' $eza_params_no_git)

alias l="eza -lhb --no-user --no-permissions" $eza_params 
alias ll="eza -labhmU -s name --git-repos $eza_params"
alias la="eza -labhm -s name $eza_params"
alias lag="eza -labhm -s name $eza_params_no_git"

alias lyadm="lazygit -ucd ~/.local/share/yadm/lazygit -w ~ -g ~/.local/share/yadm/repo.git"

alias v="nvim"
alias ssh='TERM=xterm-256color ssh'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Find all matching processes
function p(){
  ps -ef | grep -i $1 | grep -v grep | grep --color -i $1 # cursed but restores color highlighting
}

# Kill all matching processes
function ka(){
  cnt=$(p $1 | wc -l)  # total count of processes found
  klevel=${2:-15}       # kill level, defaults to 15 if argument 2 is empty

  echo -e "\nSearching for '$1' -- Found" $cnt "Running Processes .. "
  p $1

  echo -e '\nTerminating' $cnt 'processes .. '

  ps aux | grep -i $1 | grep -v grep | awk '{print $2}' | xargs kill -$klevel
  echo -e "Done!\n"

  echo "Running search again:"
  p "$1"
  echo -e "\n"
}

if is-macos; then
  alias arc="open -a Arc"
fi

if is-deck; then
  [ -f $HOME/.zsh/custom/aliases.deck.zsh ] && source $HOME/.zsh/custom/aliases.deck.zsh
fi
