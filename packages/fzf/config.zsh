# TokyoNight FZF

export FZF_DEFAULT_OPTS="\
--ansi \
--border=rounded \
--preview-window=border-rounded \
--height 100% \
--padding=1 \
--margin=1 \
--layout=reverse \
--color=bg+:#1A1E2F \
--color=bg:#1A1E2F \
--color=border:#7AA2F7 \
--color=fg:#C0CBF4 \
--color=gutter:#1D202F \
--color=header:#E0AF67 \
--color=hl+:#4FD6BE \
--color=hl:#4FD6BE \
--color=info:#404869 \
--color=marker:#F7768D \
--color=pointer:#F7768D \
--color=prompt:#4FD6BE \
--color=query:#C0CBF4:regular \
--color=scrollbar:#7AA2F7 \
--color=separator:#E0AF67 \
--color=spinner:#F7768D"

if is-ish
then
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --info=inline"
else
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --info=inline-right"
fi
