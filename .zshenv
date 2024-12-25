# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1

# Homebrew
if [[ -e /opt/homebrew/bin/brew ]]; then
  export HOMEBREW_PREFIX=/opt/homebrew
else
  export HOMEBREW_PREFIX=/usr/local
fi

#
# Editors
#

export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-nvim}"
export PAGER="${PAGER:-less}"

#
# Regional Settings
#

export LANG="${LANG:-en_US.UTF-8}"

if [[ "$OSTYPE" == darwin* && -e /opt/homebrew/bin/brew ]] then
  export LESSOPEN="|/$HOMEBREW_PREFIX/bin/lesspipe.sh %s"
else
  export LESSOPEN="|$HOME/lesspipe.sh %s"
fi

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

export ZOXIDE_CMD_OVERRIDE=cd

# TokyoNight FZF
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border
  --color=bg+:#2e3c64 \
  --color=bg:#1f2335 \
  --color=border:#29a4bd \
  --color=fg:#c0caf5 \
  --color=gutter:#1f2335 \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#29a4bd \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"

export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true

export TERMINFO_DIRS=$TERMINFO_DIRS:$HOME/.local/share/terminfo

export GOPATH=$HOME/go

path+=(/opt/local/{,s}bin)
