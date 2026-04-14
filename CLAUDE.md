# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for macOS and Ubuntu Linux. Configs are deployed via GNU Stow; packages are installed via Homebrew (Brewfile). Shell is zsh managed through antigen/oh-my-zsh with starship.

## Install / deploy

- `./install` — OS-detects, installs prerequisites (xcode-select on Darwin; zsh/podman via apt on Linux), stows `dots/.config` into `~/.config`, marks `.aws`/`.ssh` as `assume-unchanged`, and runs `brew bundle install --global`.
- Most brew/antigen lines in `install` are commented out; re-enable as needed when bootstrapping a fresh machine.
- `scripts/mac-settings.sh` — macOS `defaults write` tweaks (run manually).

## Layout that matters

- `dots/` is the Stow source tree. Only `dots/.config` is stowed by `install` (`stow -t ~/.config ./.config`). Other top-level files under `dots/` (`.zshrc`, `.gitconfig`, `.aliases`, `.Brewfile`, `.vimrc`, `.profile`, `.ssh/`, `.aws/`, `.gnupg/`, `bin/`) are **not** auto-linked — they either live where Stow/tools expect via `$HOME` conventions or must be symlinked manually. When adding a new config, prefer placing it under `dots/.config/<app>/` so it gets picked up automatically.
- `dots/.Brewfile` is the global Brewfile (`brew bundle --global` reads `~/.Brewfile`).
- `dots/bin/` contains helper scripts referenced by shell config (e.g. `upfind` is used by the `aws_auto_profile_hook` in `.zshrc`).
- `dots/.gitconfig` includes OS-specific files (`.gitconfig-mac`, `.gitconfig-linux`, `.gitconfig-work`) — platform branching lives there, not in the main gitconfig.

## Secrets hygiene

- `.aws/` and `.ssh/` are checked in but marked `git update-index --assume-unchanged` by `install`. To intentionally commit changes to them, run `git update-index --no-assume-unchanged ./dots/.aws/**` (or `.ssh`) first.
- Stow's `--adopt` can pull secret files into the repo — avoid it, especially near `.ssh`.

## Local overlays

Anything work- or host-specific goes in a `*.local` overlay in `$HOME`, never in `dots/`. `install` scaffolds empty stubs on first run (guarded by `[ ! -f ]`, so existing overlays are never overwritten):

- `~/.zshenv.local`, `~/.zprofile.local`, `~/.zshrc.local`, `~/.aliases.local`, `~/.profile.local` — sourced at the end of their tracked counterparts with a `[ -f ... ] &&` guard.
- `~/.Brewfile.local` — bundled after `~/.Brewfile` at the end of `install`.
- `~/.gitconfig-work.local` — activated by `includeIf gitdir:~/git/work/**` in `dots/.gitconfig`. Holds work email + ssh signing key.

`*.local` is in `.gitignore`. When adding new config that touches work identity, paths, or company tools, put it in the relevant overlay — not the tracked file.

## Shell architecture

`.zshrc` branches on `uname` (Darwin vs Linux) for paths/plugins, loads antigen with oh-my-zsh + a curated bundle list, then initializes `zoxide`, `fzf`, `starship`, and sources `~/.aliases`. The `aws_auto_profile_hook` (chpwd hook) walks parents with `upfind` looking for an `.aws-profile` file and exports `AWS_PROFILE` accordingly — keep that behavior in mind when editing directory-change logic.

## Formatting

`.editorconfig` and `.prettierrc` at the repo root apply to any JS/JSON/MD edits.
