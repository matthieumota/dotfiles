# Dotfiles

Dotfiles works for Arch Linux / macOS / Gentoo.  
You need Brew for macOS and Yaourt for Arch Linux.

## Usage

To use Dotfiles, you need to install it manually. It provide a more flexible way to choose things.

For config files :

- ```bin/*``` need to go to ```/usr/local/bin/*```
- ```config/fish/*``` need to go to ```~/.config/fish/*```
- ```config/git/*``` need to go to ```~/*```

For packages :

- ```brew install *``` where ```*``` is in ```packages/macos/brew.list```
- ```brew cask install *``` where ```*``` is in ```packages/macos/brew-cask.list```
- ```brew tap *``` where ```*``` is in ```packages/macos/brew-tap.list```
