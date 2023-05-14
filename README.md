# Dotfiles

This repository contains my personal dotfiles that install all the software I use, including programming languages such as Rust, Python, Node, Go, Java, Kotlin, and Groovy. All of these languages are installed using version managers and are installed in the user home with no root access needed. The only requirement is sudo access to install C and C++ compilers.

The tools I use on my terminal include Zsh as my shell, Sheldont to manage my plugins, and Starship as my prompt with their respective configuration files (starship.toml, plugin.toml, .zshenv, .zshrc). I also have some personal configurations such as my own aliases.zsh, etc.

In addition to these tools, I also install some other tools that I like to use such as Nvim, Lunarvim, Bat, Exa, Marktext, etc. All of these tools are installed in the user home so no root access is needed.

To set up everything, simply execute the following commands:

```bash
git clone https://github.com/CarlosEduardoL/dotfiles.git "$HOME/.dotfiles"
bash "$HOME/.dotfiles/setup.sh"
```
