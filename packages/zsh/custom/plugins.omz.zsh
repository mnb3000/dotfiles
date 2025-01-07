export ZSH="$ZDOTDIR/ohmyzsh"

ZSH_THEME="robbyrussell"

repos=(
  # aloxaf/fzf-tab
  zsh-users/zsh-completions
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-autosuggestions
)
for repo in $repos; do
  if [[ ! -d $ZDOTDIR/ohmyzsh/plugins/${repo:t} ]]; then
    git clone https://github.com/${repo} $ZDOTDIR/ohmyzsh/plugins/${repo:t}
  fi
done
unset repo{s,}

plugins=(
  git
  vi-mode
  # fzf

  # fzf-tab
  zsh-completions
  fast-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
