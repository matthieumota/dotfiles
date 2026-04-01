# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repository for macOS and Arch Linux. Manages system setup, configuration files, and utility scripts. Configs are symlinked from `~/.dotfiles/config/` into `~/.config/` and `~/` by the setup scripts.

## Setup

- **macOS**: `./setup-mac.sh` — installs Homebrew packages/casks, Oh My Zsh, dev tools (PHP, Node, Go, Rust), and symlinks configs
- **Arch Linux**: `./setup-arch.sh` — installs pacman/AUR packages, Oh My Zsh, dev tools, and symlinks configs

Both scripts are idempotent and meant to be run on a fresh machine.

## Structure

- `setup-mac.sh` / `setup-arch.sh` — full machine bootstrap scripts
- `bin/` — utility scripts: `brewup` (Homebrew maintenance), `checkup` (cross-platform dependency update checker), `bx-git-sync` (mirror git repos)
- `config/` — dotfiles symlinked into `~/.config/` or `~/`:
  - `zsh/` — Oh My Zsh custom aliases and PATH exports
  - `nvim/` — Neovim config (Lua-based, uses lazy.nvim plugin manager)
  - `ghostty/` — terminal emulator config with catppuccin-mocha theme
  - `niri/` — Wayland compositor config (Arch only)
  - `waybar/` — status bar config (Arch only)
  - `git/` — global .gitconfig and .gitignore_global
  - `starship.toml` — cross-shell prompt config
- `docker/` — Docker Compose setup for legacy PHP versions with nginx

## Symlink convention

Configs are linked by the setup scripts, not copied. When editing configs, edit the files in this repo — the symlinks ensure changes take effect immediately. The mapping is visible at the bottom of each setup script.
