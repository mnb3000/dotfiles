# Download latest neovim release from GitHub releases and pipe it to tar to extract it to /usr
curl -sL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$(uname -m).tar.gz" |
  sudo tar -xzf - --strip-components=1 --overwrite -C /usr
