export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Settings for Plugin fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no

# lesspipe for file/directory preview
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -laT --level 2 --no-user --no-filesize --no-permissions --no-time --icons --color=always --group-directories-first --git --git-ignore $realpath'
# git custom tabs
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
	'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	'git log --color=always $word'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'
zstyle ':fzf-tab:*' use-fzf-default-opts yes

if is-macos; then
  zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'
fi

fpath+=${ZDOTDIR:-~/.zsh}/completions

