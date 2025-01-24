# TokyoNight FZF

FZF_DEFAULT_OPTS=" \
  --ansi \
  --border=rounded \
  --preview-window=border-rounded \
  --height 80% \
  --padding=1 \
  --margin=1 \
  --layout=reverse \
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
if is-ish
then
  FZF_DEFAULT_OPTS+="--info=inline"
else
  FZF_DEFAULT_OPTS+="--info=inline-right"
fi
