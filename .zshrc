# Startup time profiling
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
fi

# funcs used in .zplugins
function is-macos {
  [[ "$OSTYPE" == darwin* ]] || return 1
}

# zstyle config
[[ -f $HOME/.zstyles ]] && source $HOME/.zstyles

fpath+="~/.zsh/completions/"

if is-macos; then
  fpath+="$HOMEBREW_PREFIX/share/zsh/site-functions"

  eval "$(mise activate zsh --shims)"
fi

local zplugins=$HOME/.zplugins

if [[ -e /opt/homebrew/bin/brew && -e $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh ]]; then
  export ANTIDOTE_HOME=$HOMEBREW_PREFIX/opt/antidote/
else
  export ANTIDOTE_HOME=${XDG_DATA_HOME:-~/.local/share}/antidote
  if [[ ! -e $ANTIDOTE_HOME/share/antidote/antidote.zsh ]]; then
    echo "Cloning antidote..."
    git clone --quiet --depth 1 https://github.com/mattmc3/antidote $ANTIDOTE_HOME/mattmc3/antidote
    touch $zplugins
  fi
fi

source $ANTIDOTE_HOME/share/antidote/antidote.zsh

# # Cache static antidote plugin file.
if [[ ! ${zplugins}.zsh -nt $zplugins ]] || [[ ! -d $ANTIDOTE_HOME ]]; then
  (antidote bundle < $zplugins >| ${zplugins}.zsh)
fi
source ${zplugins}.zsh

source $HOME/.zaliases 

eval "$(starship init zsh)"

# Startup time profiling
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi

unset ZSH_DEBUGRC
true

