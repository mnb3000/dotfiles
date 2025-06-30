# Dotfiles

Dotfile management using [Dotbot](https://github.com/anishathalye/dotbot).

## Installation

### Recursively clone the repository

```bash
~$ git clone --recursive https://github.com/mnb3000/dotfiles.git ~/.dotfiles
~$ cd ~/.dotfiles
```

### Install your preferred profile

- Install a predefined profile

```bash
~/.dotfiles$ ./install-profile <profile> [<configs...>]
```

See [meta/profiles/](./meta/profiles) for available profiles

- Install a single configuration

```bash
~/.dotfiles$ ./install-standalone <configs...>
```

See [meta/configs/](./meta/configs) for available configurations

## Profiles

<pre>
├── <a href="./meta/profiles/devices/" title="devices">📂 devices</a>
├────── <a href="./meta/profiles/devices/arch-proot" title="arch-proot">📄 arch-proot</a>
├────── <a href="./meta/profiles/devices/deck" title="deck">📄 deck</a>
├────── <a href="./meta/profiles/devices/macbook" title="macbook">📄 macbook</a>
├────── <a href="./meta/profiles/devices/orangepi" title="orangepi">📄 orangepi</a>
├────── <a href="./meta/profiles/devices/orangepi_base" title="orangepi_base">📄 orangepi_base</a>
├────── <a href="./meta/profiles/devices/studio-mini" title="studio-mini">📄 studio-mini</a>
├── <a href="./meta/profiles/distros/" title="distros">📂 distros</a>
├────── <a href="./meta/profiles/distros/alpine" title="alpine">📂 alpine</a>
├────────── <a href="./meta/profiles/distros/alpine/extra-dev" title="extra-dev">📄 extra-dev</a>
├────────── <a href="./meta/profiles/distros/alpine/minimal" title="minimal">📄 minimal</a>
├────────── <a href="./meta/profiles/distros/alpine/utm" title="utm">📄 utm</a>
├────────── <a href="./meta/profiles/distros/alpine/webvm" title="webvm">📄 webvm</a>
├────── <a href="./meta/profiles/distros/arch" title="arch">📂 arch</a>
├────────── <a href="./meta/profiles/distros/arch/utm" title="utm">📂 utm</a>
├────────────── <a href="./meta/profiles/distros/arch/utm/awesomewm" title="awesomewm">📄 awesomewm</a>
├────────────── <a href="./meta/profiles/distros/arch/utm/extra-dev" title="extra-dev">📄 extra-dev</a>
├────────────── <a href="./meta/profiles/distros/arch/utm/hyprland-installer" title="hyprland-installer">📄 hyprland-installer</a>
├────────────── <a href="./meta/profiles/distros/arch/utm/sway" title="sway">📄 sway</a>
├────────── <a href="./meta/profiles/distros/arch/extra-dev" title="extra-dev">📄 extra-dev</a>
├────── <a href="./meta/profiles/distros/debian" title="debian">📂 debian</a>
├────────── <a href="./meta/profiles/distros/debian/extra-dev" title="extra-dev">📄 extra-dev</a>
├────────── <a href="./meta/profiles/distros/debian/minimal" title="minimal">📄 minimal</a>
├────────── <a href="./meta/profiles/distros/debian/webvm" title="webvm">📄 webvm</a>
├────── <a href="./meta/profiles/distros/macos" title="macos">📂 macos</a>
├────────── <a href="./meta/profiles/distros/macos/base" title="base">📄 base</a>
├────── <a href="./meta/profiles/distros/ubuntu/" title="ubuntu">📂 ubuntu</a>
├────────── <a href="./meta/profiles/devices/extra-dev" title="extra-dev">📄 extra-dev</a>
├────────── <a href="./meta/profiles/devices/minimal" title="minimal">📄 minimal</a>
├────── <a href="./meta/profiles/devices/ish" title="ish">📄 ish</a>
└─────── <a href="./meta/profiles/devices/termux" title="termux">📄 termux</a>
</pre>
