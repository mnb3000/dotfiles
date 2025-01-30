# Dotfiles

Dotfile management using [Dotbot](https://github.com/anishathalye/dotbot).

## Installation

```bash
~$ git clone --recursive https://github.com/mnb3000/dotfiles.git ~/.dotfiles
~$ cd ~/.dotfiles
```

### For installing a predefined profile

```bash
~/.dotfiles$ ./install-profile <profile> [<configs...>]
```

See [meta/profiles/](./meta/profiles) for available profiles

### For installing single configurations

```bash
~/.dotfiles$ ./install-standalone <configs...>
```

See [meta/configs/](./meta/configs) for available configurations

## Contents

### Profiles

<pre>
meta/profiles
└── <a href="./meta/profiles/macbook" title="macbook">macbook</a>
├── <a href="./meta/profiles/deck" title="deck">deck</a>
├── <a href="./meta/profiles/termux" title="termux">termux</a>
</pre>
