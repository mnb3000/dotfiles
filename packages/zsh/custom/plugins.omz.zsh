export ZSH="$ZDOTDIR/ohmyzsh"
export HOST=$(cat /etc/hostname)

if [[ ! -d $ZSH ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

theme_repos=(
  romkatv/powerlevel10k
  # spaceship-prompt/spaceship-prompt
)

for repo in $theme_repos; do
  if [[ ! -d $ZSH/custom/themes/${repo:t} ]]; then
    git clone https://github.com/${repo} $ZSH/custom/themes/${repo:t}
  fi
done
unset repo
unset theme_repos

ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="spaceship-prompt/spaceship"

DISABLE_MAGIC_FUNCTIONS=true
ZSH_DISABLE_COMPFIX=true
DISABLE_AUTO_UPDATE=true

plugin_repos=(
  aloxaf/fzf-tab
  zsh-users/zsh-completions
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-autosuggestions
  romkatv/zsh-defer
)
for repo in $plugin_repos; do
  if [[ ! -d $ZDOTDIR/ohmyzsh/plugins/${repo:t} ]]; then
    git clone https://github.com/${repo} $ZDOTDIR/ohmyzsh/plugins/${repo:t}
  fi
done
unset repo
unset plugin_repos

plugins=(
  git
  vi-mode
  fzf
  tmux
)

fpath+=${ZSH:-~/.oh-my-zsh}/plugins/zsh-completions/src

autoload -Uz $ZSH/plugins/zsh-defer/zsh-defer

zsh-defer src $ZSH/plugins/fzf-tab/fzf-tab.zsh
zsh-defer src $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
zsh-defer src $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

src $ZSH/oh-my-zsh.sh
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || src $ZDOTDIR/.p10k.zsh
