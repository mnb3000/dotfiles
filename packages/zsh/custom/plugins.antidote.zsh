if [[ -e $HOMEBREW_PREFIX/bin/brew && -e $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh ]]; then
  export ANTIDOTE_HOME=$HOMEBREW_PREFIX/opt/antidote/
else
  export ANTIDOTE_HOME=${XDG_DATA_HOME:-~/.local/share}/antidote
  if [[ ! -e $ANTIDOTE_HOME/share/antidote/antidote.zsh ]]; then
    echo "Cloning antidote..."
    git clone --quiet --depth 1 https://github.com/mattmc3/antidote $ANTIDOTE_HOME/share/antidote
    touch $zplugins
  fi
fi

source $ANTIDOTE_HOME/share/antidote/antidote.zsh

# Cache static antidote plugin file.
if [[ ! ${zplugins}.zsh -nt $zplugins ]] || [[ ! -d $ANTIDOTE_HOME ]]; then
  (antidote bundle < $zplugins >| ${zplugins}.zsh)
fi
source ${zplugins}.zsh
