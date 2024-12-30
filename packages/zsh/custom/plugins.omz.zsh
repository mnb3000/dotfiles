export ZSH="$ZDOTDIR/ohmyzsh"

ZSH_THEME="robbyrussell"

repos=(
  aloxaf/fzf-tab
  djui/alias-tips
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
)
for repo in $repos; do
  if [[ ! -d $ZDOTDIR/ohmyzsh/plugins/${repo:t} ]]; then
    git clone https://github.com/${repo} $ZDOTDIR/ohmyzsh/plugins/${repo:t}
  fi
done
unset repo{s,}

plugins=(
  git
  sudo
  python
  docker
  docker-compose
  colored-man-pages
  vi-mode
  zoxide
  fzf

  fzf-tab
  alias-tips
  zsh-completions
  fast-syntax-highlighting
  zsh-autosuggestions
  zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh
