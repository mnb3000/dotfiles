system_type=$(uname -s)
if [ "$system_type" = "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Added by Toolbox App
  export PATH="$PATH:/Users/mnb3000/Library/Application Support/JetBrains/Toolbox/scripts"

  eval "$(mise activate zsh --shims)"

  export LESSOPEN="|/opt/homebrew/bin/lesspipe.sh %s"

  eval $(gdircolors $HOME/.dir_colors)
else
  export LESSOPEN="|/root/lesspipe.sh %s"

  eval $(dircolors -b $HOME/.dir_colors)
fi

