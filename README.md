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
├── <a href="./meta/profiles/deck" title="deck">📄 deck</a>
├── <a href="./meta/profiles/macbook" title="macbook">📄 macbook</a>
├── <a href="./meta/profiles/ish" title="ish">📄 ish</a>
├── <a href="./meta/profiles/orangepi" title="orangepi">📄 orangepi</a>
├── <a href="./meta/profiles/orangepi_base" title="orangepi_base">📄 orangepi_base</a>
├── <a href="./meta/profiles/termux" title="termux">📄 termux</a>
├── <a href="./meta/profiles/extra-dev/" title="extra-dev">📂 extra-dev</a>
    ├── <a href="./meta/profiles/extra-dev/alpine" title="extra-dev-alpine">📄 alpine</a>
    ├── <a href="./meta/profiles/extra-dev/arch" title="extra-dev-arch">📄 arch</a>
    ├── <a href="./meta/profiles/extra-dev/debian" title="extra-dev-debian">📄 debian</a>
    └── <a href="./meta/profiles/extra-dev/ubuntu" title="extra-dev-ubuntu">📄 ubuntu</a>
├── <a href="./meta/profiles/minimal/" title="minimal">📂 minimal</a>
    ├── <a href="./meta/profiles/minimal/alpine" title="minimal-alpine">📄 alpine</a>
    ├── <a href="./meta/profiles/minimal/debian" title="minimal-debian">📄 debian</a>
    └── <a href="./meta/profiles/minimal/ubuntu" title="minimal-ubuntu">📄 ubuntu</a>
├── <a href="./meta/profiles/utm/" title="utm">📂 utm</a>
    ├── <a href="./meta/profiles/minimal/alpine" title="alpine-utm">📄 alpine-utm</a>
    ├── <a href="./meta/profiles/minimal/arch-utm" title="arch-utm">📄 arch-utm</a>
    ├── <a href="./meta/profiles/minimal/arch-awesomewm-utm" title="arch-awesomewm-utm">📄 arch-awesomewm-utm</a>
    └── <a href="./meta/profiles/minimal/arch-sway-utm" title="arch-sway-utm">📄 arch-sway-utm</a>
└── <a href="./meta/profiles/webvm/" title="webvm">📂 webvm</a>
    ├── <a href="./meta/profiles/webvm/alpine" title="webvm-alpine">📄 alpine</a>
    └── <a href="./meta/profiles/webvm/debian" title="webvm-debian">📄 debian</a>
</pre>
